import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/startscreen/GeneratedStartscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/storyscreen1/GeneratedStoryscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/LoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen1/LogupscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen2/Logupscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedfavoritescreenwidget/GeneratedFavoritescreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen1widget/GeneratedForgotpasswordscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen2widget/GeneratedForgotpasswordscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen3widget/GeneratedForgotpasswordscreen3Widget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/MainScreen.dart';

import 'setting.dart';

void main() {
  runApp(lightsApp());
}

class lightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setting.setWidthSize(MediaQuery.of(context).size.width);
    setting.setHeightSize(MediaQuery.of(context).size.height);
    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedLoginscreenWidget',
      routes: {
        '/GeneratedStartscreenWidget': (context) =>
            GeneratedStartscreenWidget(),
        '/GeneratedHelloscreenWidget': (context) =>
            GeneratedHelloscreenWidget(),
        '/GeneratedStoryscreen1Widget': (context) =>
            GeneratedStoryscreen1Widget(),
        '/GeneratedLoginscreenWidget': (context) =>
            GeneratedLoginscreenWidget(),
        '/GeneratedLogupscreen1Widget': (context) =>
            GeneratedLogupscreen1Widget(),
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
        '/GeneratedMainScreenWidget': (context) => GeneratedMainScreenWidget(),
      },
    ));
  }
}
