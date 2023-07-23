import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/daily_task.dart';
import 'package:flutterapp/setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setting.setWidthSize(MediaQuery.of(context).size.width);
    setting.setHeightSize(MediaQuery.of(context).size.height);

    print(setting.heightSize == null);
    print(setting.widthSize == null);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Template Button Example')),
        body: Container(
          color: Colors.red,
          child: Center(
            child: DailyTaskProxy()
          ),
        )
      ),
    );
  }
}