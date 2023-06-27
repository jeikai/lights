import 'package:flutter/material.dart';
import 'package:flutterapp/lightsapp/generatedstartscreenwidget/GeneratedStartscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedstoryscreen1widget/GeneratedStoryscreen1Widget.dart';
import 'package:flutterapp/lightsapp/generatedafterstoryscreenwidget/GeneratedAfterstoryscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedwhentouchloginbuttonwidget/GeneratedWhentouchloginbuttonWidget.dart';
import 'package:flutterapp/lightsapp/generatedloginscreenwidget/GeneratedLoginscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedforgotpasswordscreen1widget/GeneratedForgotpasswordscreen1Widget.dart';
import 'package:flutterapp/lightsapp/generatedforgotpasswordscreen2widget/GeneratedForgotpasswordscreen2Widget.dart';
import 'package:flutterapp/lightsapp/generatedforgotpasswordscreen3widget/GeneratedForgotpasswordscreen3Widget.dart';
import 'package:flutterapp/lightsapp/generatedwhentouchlogupbuttonwidget/GeneratedWhentouchlogupbuttonWidget.dart';

void main() {
  runApp(lightsApp());
}

class lightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedStartscreenWidget',
      routes: {
        '/GeneratedStartscreenWidget': (context) =>
            GeneratedStartscreenWidget(),
        '/GeneratedHelloscreenWidget': (context) =>
            GeneratedHelloscreenWidget(),
        '/GeneratedStoryscreen1Widget': (context) =>
            GeneratedStoryscreen1Widget(),
        '/GeneratedAfterstoryscreenWidget': (context) =>
            GeneratedAfterstoryscreenWidget(),
        '/GeneratedWhentouchloginbuttonWidget': (context) =>
            GeneratedWhentouchloginbuttonWidget(),
        '/GeneratedLoginscreenWidget': (context) =>
            GeneratedLoginscreenWidget(),
        '/GeneratedForgotpasswordscreen1Widget': (context) =>
            GeneratedForgotpasswordscreen1Widget(),
        '/GeneratedForgotpasswordscreen2Widget': (context) =>
            GeneratedForgotpasswordscreen2Widget(),
        '/GeneratedForgotpasswordscreen3Widget': (context) =>
            GeneratedForgotpasswordscreen3Widget(),
        '/GeneratedWhentouchlogupbuttonWidget': (context) =>
            GeneratedWhentouchlogupbuttonWidget(),
      },
    );
  }
}
