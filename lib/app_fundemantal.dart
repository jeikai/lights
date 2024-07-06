import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/util/ConfigManager.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/image/ImageManager.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';

import 'reusable_widget/toast.dart';

class MyApp {
  BoolWarpper isPreRunFinished = BoolWarpper(false);

  static NotificationManager? manager;

  bool _prerunFinished = false;

  bool get isFinished => _prerunFinished;

  MyApp(Widget main, Widget mainloading) {
    WidgetsFlutterBinding.ensureInitialized()
        .addObserver(AppLifecycleObserver(this));
    runApp(_AppFund(
      this,
      isPreRunFinished,
      child: main,
      loading: mainloading,
      key: Key("Fundemental"),
    ));
  }

  //Method chạy trước khi App được chạy
  Future<void> preRun() async {
    await ConfigManager().setup();
    print("ConfigManager setup finished");
    await RiveUtil().setup();
    print("RiveUtil setup finished");
    await ImageManager().setup();
    print("ImageManager setup finished");
    await Preferences.init();
    print("Preferences init finished");
    manager = NotificationManager();
    print("NotificationManager init finished");
    _prerunFinished = true;
  }

  void onPreRunFinish() {
    //print("b");
    manager!.runNotiProcess();
    //print(manager!.eventCallable.handlers.length);
  }

  void onPaused() {
    if (manager != null) manager!.process.stop();
    NotificationManager().saveNotificationsToLocalStorage();
  }

  void onResumed() {
    if (manager != null) manager!.runNotiProcess();
  }

  void onInactive() {
  }

  void onDetached() {
    if (manager != null) manager!.dispose();
  }
}

class _AppFund extends StatefulWidget {
  final Widget? child;
  final MyApp myapp;
  final BoolWarpper prerun;
  final Widget? loading;

  const _AppFund(this.myapp, this.prerun,
      {super.key, this.child, this.loading});

  @override
  State<_AppFund> createState() => _AppFundState();
}

class _AppFundState extends State<_AppFund> {
  get _showLoading => widget.prerun.isFalse();
  set loading(bool b) {
    widget.prerun.b = b;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      key: Key("LoadingSwitcher"),
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOutBack,
      duration: Duration(milliseconds: 1000),
      // Duration of the transition animation
      child: _showLoading
          ? widget.loading ??
              Container(
                key: ValueKey('loading'),
                color: Colors.yellow,
              )
          : widget.child ??
              Container(
                key: ValueKey('child'),
                color: Colors.black,
              ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.prerun.isFalse()) {
      widget.myapp.preRun().then((o) {
        widget.myapp.onPreRunFinish();
        print("prerun finished");
        widget.prerun.setTrue();
        setState(() {
          loading =
              true; // Switch to the child content after prerun is finished
        });
      }).timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("PreRun timeout");
      }).catchError((error){
        setState(() {
          loading =
          true; // Switch to the child content after prerun is finished
        });
        if(widget.myapp.isFinished) return;
        ToastNoti.show("Gặp lỗi khi khởi động");
        throw error;
      });
    }
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  MyApp myapp;

  AppLifecycleObserver(this.myapp);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state case AppLifecycleState.paused) {
      myapp.onPaused();
      // break;
    } else if (state case AppLifecycleState.resumed) {
      myapp.onResumed();
      // break;
    } else if (state case AppLifecycleState.inactive) {
      myapp.onInactive();
      // break;
    } else if (state case AppLifecycleState.detached) {
      myapp.onDetached();
      // break;
    }
  }
}

class BoolWarpper {
  bool b;

  BoolWarpper(this.b);

  void setTrue() {
    b = true;
  }

  void setFalse() {
    b = false;
  }

  void toggle() {
    b = !b;
  }

  bool isTrue() {
    return b == true;
  }

  bool isFalse() {
    return b == false;
  }

  bool getValue() {
    return b;
  }
}
