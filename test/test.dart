import 'package:flutterapp/model/notification.dart';
import 'package:flutterapp/util/Event.dart';
import 'package:flutterapp/util/process/notification/NotificationEvent.dart';

void main() {
  NotificationProcess(pollingInterval: Duration(seconds: 1)).run();
  print("b");
}

class NotificationProcess {
  late NotificationEventCallable callable;

  late Duration _pollingInterval;

  bool _isRunning = false;

  NotificationProcess({required Duration pollingInterval}) {
    callable = NotificationEventCallable();
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
      await _fetchNotificationsFromServer();
      await Future.delayed(_pollingInterval);
    }
  }

  Future<void> _fetchNotificationsFromServer() async {
    try {
      print("a");
      // Make an HTTP request to fetch notifications from the server
      // Example using the http package:
      // final response = await http.get('your_api_endpoint_here');
      // Parse the response and extract the notifications
      // Add the new notifications to the NotificationManager
      // NotificationManager.getInstance().addNotification(newNotification);
    } catch (e) {
      print('Error fetching notifications: $e');
      // Handle errors, such as retrying or logging errors
    }
  }

  void callEvent(NotificationContent notificationContent) {
    callable.setEvent(NotificationEvent(notificationContent));
    callable.callEvent();
  }

  void addListener(
      void Function(NotificationEvent event) callback, Priorities priority) {
    callable.addHandler(callback, priority);
  }
}