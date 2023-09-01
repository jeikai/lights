import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/egg_screen/egg_screen.dart';
import 'package:flutterapp/view/lightsapp/favoriteScreen/FavoriteScreen.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen1widget/GeneratedForgotpasswordscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen2widget/GeneratedForgotpasswordscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen3widget/GeneratedForgotpasswordscreen3Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/LoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen1/LogupscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen2/Logupscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/MainScreen.dart';
import 'package:flutterapp/view/lightsapp/storyscreen1/GeneratedStoryscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/whaleMenu/whale_menu.dart';

import 'app_fundemantal.dart';
import 'setting.dart';

void main() {
  MyApp(
      _LightsApp(),
      _Loading(
        key: Key("loading"),
      ));
}

void initState() {
  RiveUtil riveUtil = RiveUtil();
  riveUtil.setup();
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
        ),
      ),
    );
  }
}

class _LightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Setting.setWidthSize(size.width);
    Setting.setHeightSize(size.height);
    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Light\'s',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedLoginscreenWidget',
      routes: {
        '/GeneratedStartscreenWidget': (context) => Egg_Screen(),
        '/GeneratedHelloscreenWidget': (context) =>
            GeneratedHelloscreenWidget(),
        '/GeneratedStoryscreen1Widget': (context) =>
            GeneratedStoryscreen1Widget(),
        '/GeneratedLoginscreenWidget': (context) =>
            GeneratedLoginscreenWidget(),
        '/GeneratedLogupscreen1Widget': (context) => LogupScreen(),
        '/GeneratedLogupscreen2Widget': (context) =>
            GeneratedLogupscreen2Widget(),
        '/GeneratedFavoritescreenWidget': (context) =>
            GeneratedFavoritescreenWidget(),
        '/GeneratedForgotpasswordscreen1Widget': (context) =>
            GeneratedForgotpasswordscreen1Widget(),
        '/GeneratedForgotpasswordscreen2Widget': (context) =>
            GeneratedForgotpasswordscreen2Widget(),
        '/GeneratedForgotpasswordscreen3Widget': (context) =>
            GeneratedForgotpasswordscreen3Widget(),
      },
      onGenerateRoute: (RouteSettings setting) {
        switch (setting.name) {
          case '/WhaleMenu':
            return NoAnimationPageRoute(builder: (context) => WhaleMenu());
          case '/GeneratedMainScreenWidget':
            return NoAnimationPageRoute(
                builder: (context) => MainScreenWidget());
        }
      },
    ));
  }
}

class NoAnimationPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  NoAnimationPageRoute({required this.builder});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
