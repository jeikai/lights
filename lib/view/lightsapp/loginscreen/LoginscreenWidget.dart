import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_Forget_Pass.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';

import 'package:flutterapp/reusable_widget/Title.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/setting.dart';

final _email = TextEditingController();
String email = '';
final _password = TextEditingController();
String password = '';

class GeneratedLoginscreenWidget extends StatelessWidget {
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
                child: title("ĐĂNG NHẬP"),
              ),
              Positioned(
                top: (width / 100 - 0.5) * 15,
                child: Wrap(
                  spacing: 29,
                  children: [
                    Insta(),
                    Twitter(),
                    Google(),
                    Facebook()
                  ],
                ),
              ),
              Positioned(
                top: width * 25 / 100,
                child: Text_HoacVoi(),
              ),
              Positioned(
                top: width * 50 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Mật khẩu của bạn', _password, password, context),
              ),
              Positioned(
                top: width * 82 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate(
                    "Đăng ký", context, '/GeneratedLogupscreen1Widget'),
              ),
              Positioned(
                top: width * 35 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Email của bạn', _email, email, context),
              ),
              Positioned(
                top: width * 60 / 100,
                right: null,
                bottom: null,
                width: 200.0,
                height: 33.0,
                child: Text_Quen(),
              ),
              Positioned(
                top: width * 70 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate(
                    "Đăng nhập", context,  '/GeneratedMainScreenWidget'),
              ),
            ]),
      ),
    ));
  }
}
