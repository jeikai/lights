import 'dart:ui';

import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/util/process/notification/NotificationEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Event.dart';
import 'NotificationProcess.dart';

class NotificationManager {
  late List<NotificationContent> notificationList;
  bool _isLoadingFromStorage = true;
  NotificationProcess process = NotificationProcess(pollingInterval: Duration(seconds: 10));


  NotificationManager() {
    loadNotificationsFromLocalStorage().then((value) {
      notificationList = value;
      _isLoadingFromStorage = false;
      _runNotiProcess();
    });
  }

  void _runNotiProcess() {
    process.run();
  }

  bool isLoading() {
    return _isLoadingFromStorage;
  }

  void addNotification(NotificationContent notificationContent) {

  }

  void removeNotification(NotificationContent notificationContent) {

  }

  List<NotificationContent> getUnreadNotifications() {
    return [];
  }

  List<NotificationContent> getAllNotifications() {
    return _isLoadingFromStorage ? [] : notificationList;
  }

  void markNotificationAsRead(NotificationContent notificationContent) {
    notificationContent.isRead = true;
  }

  void clearAllNotifications() {
    notificationList.clear();
  }

  int getNotificationCount() {
    return notificationList.length;
  }

  // Saving notifications to local storage
  void saveNotificationsToLocalStorage(List<NotificationContent> notificationList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notificationStrings = notificationList.map((notification) => notification.toMap().toString()).toList();
    await prefs.setStringList('notificationList', notificationStrings);
  }

  // Loading notifications from local storage
  Future<List<NotificationContent>> loadNotificationsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notificationStrings = prefs.getStringList('notificationList') ?? [];
    List<NotificationContent> notifications = notificationStrings.map((string) => NotificationContent.fromMap(string)).toList();
    return notifications;
  }

  void addListender(void Function(NotificationEvent event) callback, Priorities priority) {
    process.addListener(callback, priority);
  }
}