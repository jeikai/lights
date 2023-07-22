import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Template Button Example')),
        body: Container(
          color: Colors.red,
          child: Center(
            child: Container(
              width: 500,
              height: 500,
              child: DTListView(
                deviderHeight: 1.5,
                deviderColor: Colors.blueGrey,
              ),
            ),
          ),
        )
      ),
    );
  }
}