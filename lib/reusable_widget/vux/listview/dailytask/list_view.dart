import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/normal_cell.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/proxy_view_widget.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

import '../../../../model/model_data.dart';

class DTListView extends StatefulWidget {
  static const Color dcDefault = Color.fromARGB(255, 212, 216, 234);
  final Color deviderColor;
  final double deviderHeight;
  final double borderRadius;
  final Color bgColor;
  final double textSize;

  const DTListView(
      {Key? key,
      this.deviderColor = dcDefault,
      this.deviderHeight = 1.5,
      this.borderRadius = 16,
      this.bgColor = Colors.white,
      this.textSize = 15})
      : super(key: key);

  @override
  _DTListViewState createState() => _DTListViewState();
}

class _DTListViewState extends State<DTListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller4Normal;
  List<Artboard?> riveArtboard = [];

  List<TaskData> tasks = [
    TaskData(taskDes: "Thien trong 10p", percent: 0.0),
    TaskData(taskDes: "Thien trong 20p", percent: 1.0),
    TaskData(taskDes: "Thien trong 30p", percent: 0.5),
    TaskData(taskDes: "Thien trong 50p", percent: 0.25)
  ];

  @override
  void initState() {
    super.initState();
    _controller4Normal = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _controller4Normal.dispose();
    super.dispose();
  }

  List<Widget> genList() {
    List<Widget> res = [];
    int index = 0;
    for (var value in tasks) {
      res.add(Expanded(
          child: NormalCell(
        controller: _controller4Normal,
        percent: value.percent!,
        taskDes: value.taskDes!,
        textSize: widget.textSize,
        artboard: riveArtboard[index]!,
      )));
      res.add(Divider(
        color: widget.deviderColor,
        thickness: widget.deviderHeight,
      ));
      index++;
    }
    res.add(SizedBox(height: 20));
    return res;
  }

  Future<void> fetchDailyTask() async {
    RiveUtil util = RiveUtil();
    var a = Future.delayed(Duration(seconds: 5));
    List<Future> waitList = [a];
    for (int i = 0; i < 4; i++) {
      final file = util.getStar();
      final artboard = file.mainArtboard;
      riveArtboard.add(artboard);
    }
    await Future.wait(waitList);
    _controller4Normal.reset();
    _controller4Normal.forward();
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: widget.bgColor,
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
    return Container(
        decoration: decoration,
        child: FutureBuilder(
            future: fetchDailyTask(),
            builder: (context2, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ProxyViewWidget(
                      deviderColor: widget.deviderColor,
                      deviderHeight: widget.deviderHeight,
                      bgColor: widget.bgColor,
                      textSize: widget.textSize),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text('Error occurred while loading data.'),
                );
              } else {
                var children = genList();
                return Column(
                  children: children,
                );
              }
            }));
  }
}
