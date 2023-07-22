import 'package:flutter/material.dart';

import '../../../shimmer.dart';
import '../../progress_bar.dart';


class ProxyViewWidget extends StatelessWidget {
  final Color deviderColor;
  final double deviderHeight;
  final Color bgColor;
  final double pbThickness;
  final double textSize;

  const ProxyViewWidget({Key? key, this.deviderColor = Colors.black, this.deviderHeight = 2, this.bgColor = Colors.white, this.pbThickness = 5, required this.textSize}) : super(key: key);

  List<Widget> genList() {
    List<Widget> res = [];
    for (int i = 0; i < 4; i ++) {
      res.add(
          Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.white12,
                child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double l_w = constraints.maxWidth * 0.75;
                      double r_w = constraints.maxWidth * 0.25;
                      return Row(
                        children: [
                          Container(
                            width: l_w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ProgressBar.color2,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  height: textSize + 10,
                                  width: l_w * 0.8,
                                ),
                                ProgressBar(
                                  value: 0.0,
                                  height: pbThickness,
                                  width: l_w * 0.8,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: r_w,
                            child: Padding(
                              padding: EdgeInsets.all(r_w * 0.15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ProgressBar.color2,
                                    borderRadius: BorderRadius.circular(r_w * 0.4 * 0.25)
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                ),
              ),
          )
      );
      res.add(
          Divider(
            color: deviderColor,
            thickness: deviderHeight,
          )
      );
    }
    res.add(
        SizedBox( height: 20 )
    );
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
