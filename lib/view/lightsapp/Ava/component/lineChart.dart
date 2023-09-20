import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/EmotionData.dart';

class lineChart extends StatelessWidget {
  final List<EmotionData> datas;

  const lineChart(this.datas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: 1,
            child: LineChart(LineChartData(lineBarsData: [
              LineChartBarData(
                spots: datas.map((e) => FlSpot(e.x, e.y)).toList(),
                isCurved: false,
                dotData: FlDotData(show: true),
              ),
            ]))),
      ],
    );
  }
}
