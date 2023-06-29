import 'package:flutter/material.dart';
import 'package:flutterapp/lightsapp/generatedhelloscreenwidget/generated/Generated86Widget.dart';
import 'package:flutterapp/lightsapp/generatedhelloscreenwidget/generated/GeneratedXinchoMnhlLightsWidget.dart';

/* Frame Hello screen
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedHelloscreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/GeneratedStoryscreen1Widget'),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Container(
          width: 360.0,
          height: 800.0,
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.asset(
                    "assets/images/3890c3231620d942b721643b360ba38e7aa00362.png",
                    color: null,
                    fit: BoxFit.cover,
                    width: 360.0,
                    height: 800.0,
                    colorBlendMode: BlendMode.dstATop,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Positioned(
                        left: 77.0,
                        top: 50.0,
                        right: null,
                        bottom: null,
                        width: 207.0,
                        height: 105.0,
                        child: GeneratedXinchoMnhlLightsWidget(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 55.0,
                  top: 253.0,
                  right: null,
                  bottom: null,
                  width: 273.0,
                  height: 450.0,
                  child: Generated86Widget(),
                )
              ]),
        ),
      ),
    ));
  }
}