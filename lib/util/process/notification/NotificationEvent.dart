import 'package:flutterapp/util/Event.dart';

import '../../../model/notification.dart';
import 'NotificationManager.dart';

class NotificationEvent extends Event with Cancelable {
  final NotificationContent notificationContent;

  NotificationEvent(this.notificationContent);
}

class NotificationEventCallable extends EventCallable<NotificationEvent> {
  late NotificationManager manager;

  NotificationEventCallable() {
    manager = NotificationManager();
    this.addHandler((event) {
      manager.addNotiWithoutEvent(event.notificationContent);
    }, Priorities.low);
  }

  @override
  void preCall() {}

  @override
  void postCall() {}
}
