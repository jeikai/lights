import 'package:flutterapp/util/Event.dart';

import '../../../model/notification.dart';

class NotificationEvent extends Event with Cancelable {
  final NotificationContent notificationContent;

  NotificationEvent(this.notificationContent);
}

class NotificationEventCallable extends EventCallable<NotificationEvent> {
  NotificationEventCallable();

  @override
  void preCall() {}

  @override
  void postCall() {}
}
