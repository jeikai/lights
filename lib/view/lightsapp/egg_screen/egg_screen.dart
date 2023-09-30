import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Quote_text.dart';
import 'package:flutterapp/reusable_widget/Title_white.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/setting.dart';

import 'generated/GeneratedEgg1Widget.dart';

class EggScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
    // ignore: unused_local_variable
    var height = Setting.getHeightSize();
    return Material(
        child: ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(alignment: Alignment.center, children: [
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
        EggWidget()
      ]),
    ));
  }
}
