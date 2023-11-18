import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Logo_Twitter.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Circle_Twitter.dart';
import 'package:flutterapp/helpers/transform/transform.dart';

/* Group twitter
    Autogenerated by FlutLab FTF Generator
  */
class Twitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          //overflow: Overflow.visible,
          children: [
            Positioned(
              left: 0.0,
              top: 0.0,
              right: null,
              bottom: null,
              width: 60.0,
              height: 60.0,
              child: CircleTwitter(),
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              bottom: 0.0,
              width: null,
              height: null,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                double percentWidth = 0.6122449239095052;
                double scaleX =
                    (constraints.maxWidth * percentWidth) / 36.73469543457031;

                double percentHeight = 0.4897959073384603;
                double scaleY = (constraints.maxHeight * percentHeight) /
                    29.387754440307617;

                return Stack(children: [
                  TransformHelper.translateAndScale(
                      translateX: constraints.maxWidth * 0.17346903483072917,
                      translateY: constraints.maxHeight * 0.2551020463307699,
                      translateZ: 0,
                      scaleX: scaleX,
                      scaleY: scaleY,
                      scaleZ: 1,
                      child: GeneratedVectorWidget1())
                ]);
              }),
            )
          ]),
    );
  }
}
