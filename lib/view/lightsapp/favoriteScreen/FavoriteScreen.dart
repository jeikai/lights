import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Navigate.dart';
import 'package:flutterapp/reusable_widget/Quote_text.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/setting.dart';

class GeneratedFavoritescreenWidget extends StatelessWidget {
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
                  "assets/images/e283b33ab7375327428a58bc4d7aa0f81936911c.png"),
              Positioned(
                top: width * 30 / 100,
                right: null,
                bottom: null,
                width: 273.0,
                height: 450.0,
                child: Whale(),
              ),
              Positioned(
                top: width * 5 / 100,
                child: title("Hãy chọn điều\n bạn thích!!!"),
              ),
              Positioned(
                top: width * 80 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate(
                    "Hoàn tất", context, '/GeneratedStartscreenWidget'),
              ),
              Positioned(
                top: width * 90 / 100,
                right: null,
                bottom: null,
                width: 284.0,
                height: 24.0,
                child: quote("*các mục được chọn sẽ có màu vàng"),
              )
            ]),
      ),
    ));
  }
}
