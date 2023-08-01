import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/vux/listview/noti/normal_cell.dart';
import 'package:flutterapp/setting.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';

void main() {
  runApp(DataCaching());
}

class DataCaching extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DataCachingState();
}

class DataCachingState extends State<DataCaching> {
  RiveUtil? riveUtil;

  @override
  void initState() {
    super.initState();
    riveUtil = RiveUtil();
    riveUtil!.setup().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setting.setWidthSize(MediaQuery.of(context).size.width);
    setting.setHeightSize(MediaQuery.of(context).size.height);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Template Button Example')),
        body: Container(
          color: Colors.red,
          child: Center(
            child: NormalCell(
              isClickable: true,
              onPress: () {
                print("press");
              },
            )
          ),
        )
      ),
    );
  }
}