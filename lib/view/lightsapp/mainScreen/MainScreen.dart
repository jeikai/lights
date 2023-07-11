import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedMissionWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedHeaderWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedSettingWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedHomeWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/Generated811Widget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedNotiWidget.dart';
import 'package:flutterapp/setting.dart';

class GeneratedMainScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = setting.getWidthSize();
    var height = setting.getHeightSize();
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            //overflow: Overflow.visible,
            children: [
              background(
                  "assets/images/85467c0186aa1e39f7aba60db02bf4fe6c044214.png"),
              Positioned(
                top: width * 30 / 100,
                right: null,
                bottom: null,
                width: 273.0,
                height: 450.0,
                child: Whale(),
              ),
              Positioned(
                left: 118.0,
                top: 719.0,
                right: null,
                bottom: null,
                width: 57.0,
                height: 57.0,
                child: GeneratedHomeWidget(),
              ),
              Positioned(
                left: 199.0,
                top: 719.0,
                right: null,
                bottom: null,
                width: 57.0,
                height: 57.0,
                child: GeneratedNotiWidget(),
              ),
              Positioned(
                left: 280.0,
                top: 719.0,
                right: null,
                bottom: null,
                width: 57.0,
                height: 57.0,
                child: GeneratedMissionWidget(),
              ),
              Positioned(
                left: 0.0,
                top: 0.0,
                right: null,
                bottom: null,
                width: 360.0,
                height: 52.0,
                child: GeneratedHeaderWidget(),
              ),
              Positioned(
                left: 11.0,
                top: 10.0,
                right: null,
                bottom: null,
                width: 38.0,
                height: 38.0,
                child: GeneratedSettingWidget(),
              )
            ]),
      ),
    );
  }
}
