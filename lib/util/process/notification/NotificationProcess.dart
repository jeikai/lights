import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';

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
      print(_pollingInterval.inSeconds);
      await Future.delayed(_pollingInterval);
    }
  }

  Future<NotificationContent?> _fetchNotificationsFromServer() async {
    NotificationContent? res;
    try {
      NotificationContent content = NotificationContent();
      res = content;
    } catch (e) {
      print('Error fetching notifications: $e');
      // Handle errors, such as retrying or logging errors
    }
    return res;
  }
}