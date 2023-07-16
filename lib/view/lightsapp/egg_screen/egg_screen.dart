import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Quote_text.dart';
import 'package:flutterapp/reusable_widget/Title_white.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/view/lightsapp/egg_screen/generated/GeneratedEgg1Widget.dart';

import 'package:flutterapp/setting.dart';

class Egg_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = setting.getWidthSize();
    var height = setting.getHeightSize();
    return Material(
        child: ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            //overflow: Overflow.visible,
            children: [
              background(
                  "assets/images/58b02374af6c7259608d3b397213825017c644cd.png"),
              Positioned(
                top: 5 * width / 100,
                child: title("Hãy chạm nhiều lần\n vào quả trứng"),
              ),
              Positioned(
                  top: width * 70 / 100,
                  child: quote(
                      "*Khi chạm vào nhiều lần thì quả trứng sẽ\n nở ra cá voi light's")),
              Positioned(
                  top: width * 80 / 100,
                  child: quote(
                      "*Càng chạm vào nhiều thì quả trứng càng\n phát sáng và ánh sáng càng loan rộng ra\n toàn màn hình")),
              // Positioned(
              //   left: 0.0,
              //   top: 0.0,
              //   right: 0.0,
              //   bottom: 0.0,
              //   width: null,
              //   height: null,
              //   child: LayoutBuilder(builder:
              //       (BuildContext context, BoxConstraints constraints) {
              //     final double width =
              //         constraints.maxWidth * 0.5138888888888888;

              //     final double height = constraints.maxHeight * 0.27375;

              //     return Stack(children: [
              //       TransformHelper.translate(
              //           x: constraints.maxWidth * 0.24166666666666667,
              //           y: constraints.maxHeight * 0.3625,
              //           z: 0,
              //           child: Container(
              //             width: width,
              //             height: height,
              //             child: GeneratedEgg1Widget(),
              //           ))
              //     ]);
              //   }),
              // )
            ]),
      ),
    ));
  }
}
