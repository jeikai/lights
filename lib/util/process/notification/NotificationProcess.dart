import 'dart:math';

import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';

String generateRandomString(int length) {
  const String _charset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random _random = Random();

  String randomString = '';
  for (int i = 0; i < length; i++) {
    int randomIndex = _random.nextInt(_charset.length);
    randomString += _charset[randomIndex];
  }

  return randomString;
}

class NotificationProcess {
  late Duration _pollingInterval;

  bool _isRunning = false;

  NotificationManager manager;

  NotificationProcess(
      {required Duration pollingInterval, required this.manager}) {
    _pollingInterval = pollingInterval;
  }

  void run() {
    if (!_isRunning) {
      _isRunning = true;
      _fetchNotificationsPeriodically();
    }
  }

  void stop() {
    _isRunning = false;
  }

  Future<void> _fetchNotificationsPeriodically() async {
    while (_isRunning) {
      var content = await _fetchNotificationsFromServer();
      if (content != null) manager.addNotification(content);
      await Future.delayed(_pollingInterval);
    }
  }

  Future<NotificationContent?> _fetchNotificationsFromServer() async {
    NotificationContent? res;
    try {
      Random _random = Random();
      NotificationContent content = NotificationContent(
          isRead: false,
          content: generateRandomString(_random.nextInt(100) + 100));
      //res = content;
    } catch (e) {
      print('Error fetching notifications: $e');
      // Handle errors, such as retrying or logging errors
    }
    return res;
  }
}
