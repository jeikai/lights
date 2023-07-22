import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/home/buttom/template.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Template Button Example')),
        body: Center(
          child: Template(
            width: 50,
            height: 50,
            icon: MyFlutterIcon.home,
            bg_color: Colors.limeAccent,
            key: Key('template_button'),
          ),
        ),
      ),
    );
  }
}