import 'package:flutterapp/util/Event.dart';

enum VuxNavigatorEventType {
  POP,
  PUSH;
}

class VuxNavigatorEvent extends Event {
  final String prev;
  final String next;
  final VuxNavigatorEventType type;

  List<Future> _waitFor = <Future>[];

  VuxNavigatorEvent(this.prev, this.next, this.type);

  void addWait(Future future) {
    _waitFor.add(future);
  }
}

class VuxNavigatorEventCallable extends EventCallable<VuxNavigatorEvent> {
  VuxNavigatorEventCallable();
}
