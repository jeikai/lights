import 'package:flutter/material.dart';
import 'package:flutterapp/util/Event.dart';
import 'package:flutterapp/util/navigator/VuxNavigatorEvent.dart';

class VuxNavigator {
  static VuxNavigatorEventCallable callable = VuxNavigatorEventCallable();

  static void addListener(void Function(VuxNavigatorEvent event) handler,
      {Priorities priority = Priorities.normal}) {
    callable.addHandler(handler, priority);
  }

  static Future<void> pop(BuildContext context) async {
    String prev = ModalRoute.of(context)!.settings.name!;
    String next = "";
    callable
        .callEvent(VuxNavigatorEvent(prev, next, VuxNavigatorEventType.POP));
    Navigator.pop(context);
  }
}
