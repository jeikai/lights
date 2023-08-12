import 'package:flutter/material.dart';
import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/util/ConfigManager.dart';
import 'package:flutterapp/util/process/notification/NotificationEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Event.dart';
import 'NotificationProcess.dart';

class NotificationManager {
  bool _isLoadingFromStorage = true;
  late NotificationProcess process;
  late NotificationEventCallable _callable;

  static NotificationManager? _instance;
  late final ListModel<NotificationContent> _list;

  factory NotificationManager() {
    if (_instance == null) {
      _instance = NotificationManager._internal();
      return _instance!;
    }
    return _instance!;
  }

  late GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  GlobalKey<AnimatedListState> get listKey => _listKey;

  NotificationManager._internal() {
    process = NotificationProcess(
        pollingInterval: Duration(seconds: ConfigManager().pollingInterval),
        manager: this);
    loadNotificationsFromLocalStorage().then((value) {
      _list = ListModel(
        listKey: _listKey,
        initialItems: value,
      );
      _isLoadingFromStorage = false;
    });
    _callable = NotificationEventCallable(this);
  }

  void runNotiProcess() {
    process.run();
  }

  bool isLoading() {
    return _isLoadingFromStorage;
  }

  void addNotification(NotificationContent notificationContent) {
    callEvent(notificationContent);
  }

  void addNotiWithoutEvent(NotificationContent notificationContent) {
    print("b");
    _list.insertTop(notificationContent);
    print(_list.length);
  }

  void removeNotification(NotificationContent notificationContent) {}

  List<NotificationContent> get unreadNotifications {
    List<NotificationContent> unread = [];
    notifications.forEach((element) {
      if (element.isRead) return;
      unread.add(element);
    });
    return unread;
  }

  List<NotificationContent> get notifications {
    return _isLoadingFromStorage ? [] : _list._items;
  }

  void markNotificationAsRead(NotificationContent notificationContent) {
    notificationContent.isRead = true;
  }

  void clearAllNotifications() {
    _list.clear();
  }

  int get notificationCount => notifications.length;

  // Saving notifications to local storage
  void saveNotificationsToLocalStorage(List<NotificationContent> notificationList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notificationStrings = notificationList.map((notification) => notification.toMap().toString()).toList();
    await prefs.setStringList('notificationList', notificationStrings);
  }

  // Loading notifications from local storage
  Future<List<NotificationContent>> loadNotificationsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notificationStrings =
        prefs.getStringList('notificationList') ?? [];
    List<NotificationContent> notifications = notificationStrings
        .map((string) => NotificationContent.fromMap(string))
        .toList();
    return notifications;
  }

  void addListener(
      void Function(NotificationEvent event) callback, Priorities priority) {
    _callable.addHandler(callback, priority);
  }

  void callEvent(NotificationContent notificationContent) {
    _callable.callEvent(NotificationEvent(notificationContent));
  }

  set removedItemBuilder(RemovedItemBuilder<NotificationContent> builder) {
    _list.removedItemBuilder = builder;
  }

  NotificationEventCallable get eventCallable => _callable;
}

class ListModel<E> {
  ListModel({
    required this.listKey,
    RemovedItemBuilder<E>? removedItemBuilder,
    Iterable<E>? initialItems,
  })  : _items = List<E>.from(initialItems ?? <E>[]),
        _removedItemBuilder = removedItemBuilder ??
            ((E item, BuildContext context, Animation<double> animation) {
              return Container();
            }) {}

  final GlobalKey<AnimatedListState> listKey;
  RemovedItemBuilder<E> _removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    if (_animatedList != null) {
      _animatedList!.insertItem(index);
    }
  }

  void insertTop(E item) {
    insert(0, item);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return _removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  set removedItemBuilder(RemovedItemBuilder<E> removedItemBuilder) {
    this._removedItemBuilder = removedItemBuilder;
  }

  void clear() {
    _items.clear();
    _animatedList!
        .removeAllItems((BuildContext context, Animation<double> animation) {
      return Container();
    });
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);