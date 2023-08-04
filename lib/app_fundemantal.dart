import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';

class MyApp {
  BoolWarpper isPreRunFinished = BoolWarpper(false);

  MyApp(Widget main, Widget mainloading) {
    WidgetsFlutterBinding.ensureInitialized()
        .addObserver(AppLifecycleObserver(this));
    print("a");
    runApp(_AppFund(
      this,
      isPreRunFinished,
      child: main,
      loading: mainloading,
      key: Key("Fundemental"),
    ));
    print("b");
  }

  //Method chạy trước khi App được chạy
  Future<void> preRun() async {
    RiveUtil();
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      print(i + 1);
    }
    return;
  }

  void onPaused() {}

  void onResumed() {}

  void onInactive() {}

  void onDetached() {}
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
  @override
  Widget build(BuildContext context) {
    return widget.prerun.getValue()
        ? widget.child ??
            Container(
              color: Colors.black,
            )
        : widget.loading ??
            Container(
              color: Colors.yellow,
            );
  }

  @override
  void initState() {
    super.initState();
    widget.myapp.preRun().whenComplete(() {
      print("prerun finished");
      widget.prerun.setTrue();
      setState(
          () {}); // This will trigger a rebuild after the prerun is finished
    });
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  MyApp myapp;

  AppLifecycleObserver(this.myapp);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        myapp.onPaused();
        break;
      case AppLifecycleState.resumed:
        myapp.onResumed();
        break;
      case AppLifecycleState.inactive:
        myapp.onInactive();
        break;
      case AppLifecycleState.detached:
        myapp.onDetached();
        break;
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
