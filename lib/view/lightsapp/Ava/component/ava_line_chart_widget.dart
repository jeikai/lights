import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/lineChart.dart';

import 'EmotionData.dart';

class AvaLineChartWidget extends StatelessWidget {
  final ValueNotifier<bool> isConfig;

  const AvaLineChartWidget({super.key, required this.isConfig});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ConfigMenuConverter(
      color: Color.fromRGBO(168, 195, 230, 1),
      oriHeight: size.height * 0.375,
      configHeight: 0,
      configChild: SizedBox(),
      isConfig: isConfig,
      child: LayoutBuilder(
        key: Key("AvaLineChartWidget"),
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            padding: EdgeInsets.all(constraints.maxWidth * 0.01),
            child: FutureBuilder<List<double>>(
              future: getDataFromApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return MyLineChart(getEmotionDatas(snapshot.data!));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
