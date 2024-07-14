import 'package:flutter/material.dart';
import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/reusable_widget/vux/listview/noti/notification_list_view.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/ConfigManager.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/process/notification/NotificationEvent.dart';

import '../../Event.dart';
import 'NotificationProcess.dart';

class NotificationManager {
  bool _isLoadingFromStorage = true;
  late NotificationProcess process;
  late NotificationEventCallable _callable;

  static NotificationManager? _instance;
  ListModel<NotificationContent>? _list;

  late GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late GlobalKey<NotificationListViewState> _listViewKey = GlobalKey<NotificationListViewState>();

  GlobalKey<AnimatedListState> get listKey => _listKey;
  GlobalKey<NotificationListViewState> get listViewKey => _listViewKey;

  factory NotificationManager() {
    if (_instance == null) {
      _instance = NotificationManager._internal();
      return _instance!;
    }
    return _instance!;
  }

  NotificationManager._internal() {
    process = NotificationProcess(
        pollingInterval: Duration(seconds: ConfigManager().pollingInterval),
        manager: this);
    _callable = NotificationEventCallable(this);
  }

  void dispose() {
    //process.stop();
  }

  void runNotiProcess() {
    //process.run();
  }

  bool isLoading() {
    return _isLoadingFromStorage;
  }

  void addNotification(NotificationContent notificationContent) {
    _callable.callAddEvent(notificationContent);
  }

  void addNotiWithoutEvent(NotificationContent notificationContent) {
    if(_list == null) return;
    _list!.insertTop(notificationContent);
  }

  void removeNotification(NotificationContent notificationContent) {
    if(_list == null) return;
    int index = _list!.indexOf(notificationContent);
    _list!.removeAt(index);
  }

  List<NotificationContent> get unreadNotifications {
    List<NotificationContent> unread = [];
    notifications.forEach((element) {
      if (element.isRead) return;
      unread.add(element);
    });
    return unread;
  }

  List<NotificationContent> get notifications {
    return _isLoadingFromStorage || _list == null ? [] : _list!._items;
  }

  void markNotificationAsRead(NotificationContent notificationContent) {
    notificationContent.isRead = true;
    _callable.callMarkReadEvent(notificationContent);
  }

  void clearAllNotifications() {
    if(_list == null) return;
    _list!.clear();
  }

  int get notificationCount => notifications.length;

  int get notificationUnreadCount => unreadNotifications.length;

  // Saving notifications to local storage
  Future<void> saveNotificationsToLocalStorage() async {
    try {
      List<dynamic> notificationMap =
          notifications.map((notification) => notification.toMap()).toList();
      Map<String, dynamic> data = {"notifications": notificationMap};
      print("Put New Noti!!");
      var temp = await Api()
          .pushDataUpdate("user/update-noti", Preferences.getId()!, data);
      print("Data: $temp");
    } catch (e) {
      print(e);
    }
  }

  // Loading notifications from local storage
  Future<List<NotificationContent>> loadNotificationsFromLocalStorage(
      List<dynamic>? input) async {
    print("Load Noti!!");
    List<NotificationContent> notificationsList;
    if (input != null) {
      List<dynamic> notificationStrings = input;
      notificationsList = notificationStrings
          .map((noti) => NotificationContent.fromMap(noti))
          .toList();
      print("Noti: $notificationsList");
    } else {
      notificationsList = [];
    }
    _list = ListModel(
      listKey: _listKey,
      initialItems: notificationsList,
    );
    _isLoadingFromStorage = false;
    reloadNotiListIfNeeded();
    return notificationsList;
  }

  void reloadNotiListIfNeeded() {
    //get the Widget with the key
    final key = listViewKey;
    if (key.currentWidget != null) {
      //get the State from the key
      final keyState = key.currentState;
      if (keyState != null) {
        //access the method in the State
        keyState.update();
      }
    }
  }

  void addListener(
      void Function(NotificationEvent event) callback, Priorities priority) {
    _callable.addHandler(callback, priority);
  }

  void removeListener(void Function(NotificationEvent event) callback) {
    _callable.removeHandler(callback);
  }

  set removedItemBuilder(RemovedItemBuilder<NotificationContent> builder) {
    if(_list == null) return;
    _list!.removedItemBuilder = builder;
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
            });

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
