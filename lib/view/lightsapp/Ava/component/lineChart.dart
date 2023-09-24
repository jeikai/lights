import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/EmotionData.dart';

class MyLineChart extends StatelessWidget {
  final List<EmotionData> datas;

  const MyLineChart(this.datas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: datas.map((e) => FlSpot(e.x, e.y)).toList(),
            isCurved: false,
            dotData: FlDotData(show: true),
          ),
        ],
        borderData: FlBorderData(
            show: true,
            border: Border(
                top: BorderSide(
                  color: Color.fromARGB(125, 144, 162, 213),
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Color.fromARGB(125, 144, 162, 213),
                  width: 2,
                ))),
        gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (double) {
              return FlLine(
                color: Color.fromARGB(125, 144, 162, 213),
              );
            }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 44,
                  showTitles: true,
                  getTitlesWidget: defaultGetTextTitle)),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 44,
                  showTitles: true,
                  getTitlesWidget: defaultGetTitle)),
          topTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 22,
                  showTitles: true,
                  getTitlesWidget: defaultGetTitle)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 22,
                  showTitles: true,
                  getTitlesWidget: defaultGetTitle)),
        ),
      ),
    );
  }

  Widget defaultGetTextTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: TextStyle(
          fontFamily: "Paytone One",
        ),
      ),
    );
  }

  Widget defaultGetTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: SizedBox(),
    );
  }
}
