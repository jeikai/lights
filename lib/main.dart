import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/generatedstartscreenwidget/GeneratedStartscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedstoryscreen1widget/GeneratedStoryscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedloginscreenwidget/GeneratedLoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedlogupscreen1widget/GeneratedLogupscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedlogupscreen2widget/GeneratedLogupscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedfavoritescreenwidget/GeneratedFavoritescreenWidget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen1widget/GeneratedForgotpasswordscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen2widget/GeneratedForgotpasswordscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedforgotpasswordscreen3widget/GeneratedForgotpasswordscreen3Widget.dart';
import 'package:flutterapp/view/lightsapp/generatedmainscreenwidget/GeneratedMainScreenWidget.dart';

void main() {
  runApp(lightsApp());
}

class lightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    );
  }
}
