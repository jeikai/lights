import 'package:flutter/material.dart';
import 'package:flutterapp/lightsapp/generatedstartscreenwidget/GeneratedStartscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/lightsapp/generatedstoryscreen1widget/GeneratedStoryscreen1Widget.dart';

void main() {
  runApp(lightsApp());
}

class lightsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
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
      },
    );
  }
}
