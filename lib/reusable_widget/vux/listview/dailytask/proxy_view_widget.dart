import 'package:flutter/material.dart';

import '../../../shimmer.dart';
import '../../progress_bar.dart';

class ProxyViewWidget extends StatelessWidget {
  final Color deviderColor;
  final double deviderHeight;
  final Color bgColor;
  final double pbThickness;
  final double textSize;

  const ProxyViewWidget(
      {Key? key,
      this.deviderColor = Colors.black,
      this.deviderHeight = 2,
      this.bgColor = Colors.white,
      this.pbThickness = 5,
      required this.textSize})
      : super(key: key);

  List<Widget> genList() {
    List<Widget> res = [];
    for (int i = 0; i < 4; i++) {
      res.add(Expanded(
        child: Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.white12,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double lW = constraints.maxWidth * 0.75;
            double rW = constraints.maxWidth * 0.25;
            return Row(
              children: [
                SizedBox(
                  width: lW,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ProgressBar.color2,
                            borderRadius: BorderRadius.circular(50)),
                        height: textSize + 10,
                        width: lW * 0.8,
                      ),
                      ProgressBar(
                        value: 0.0,
                        height: pbThickness,
                        width: lW * 0.8,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: rW,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: rW * 0.15, top: rW * 0.15, bottom: rW * 0.15),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: ProgressBar.color2,
                          borderRadius:
                              BorderRadius.circular(rW * 0.4 * 0.25)),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ));
      res.add(Divider(
        color: deviderColor,
        thickness: deviderHeight,
      ));
    }
    res.add(SizedBox(height: 20));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var children = genList();
    return Column(
      children: children,
    );
  }
}
