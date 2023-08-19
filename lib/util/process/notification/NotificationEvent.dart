import 'package:flutterapp/util/Event.dart';

import '../../../model/notification.dart';
import 'NotificationManager.dart';

enum NotificationAction {
  ADD,
  REMOVE,
  MARK_READ;
}

class NotificationEvent extends Event with Cancelable {
  final NotificationContent notificationContent;
  final NotificationAction action;

  NotificationEvent(this.notificationContent,
      {this.action = NotificationAction.ADD});
}

class NotificationEventCallable extends EventCallable<NotificationEvent> {
  late NotificationManager manager;

  NotificationEventCallable(NotificationManager manager) {
    this.manager = manager;
    this.addHandler((NotificationEvent event) {
      if (event.action == NotificationAction.ADD)
        manager.addNotiWithoutEvent(event.notificationContent);
    }, Priorities.normal);
  }

  void callAddEvent(NotificationContent content) {
    this.callEvent(NotificationEvent(content));
  }

  void callMarkReadEvent(NotificationContent content) {
    this.callEvent(
        NotificationEvent(content, action: NotificationAction.MARK_READ));
  }

  void callRemoveEvent(NotificationContent content) {
    this.callEvent(
        NotificationEvent(content, action: NotificationAction.REMOVE));
  }

  @override
  void preCall() {}

  @override
  void postCall() {}
}
