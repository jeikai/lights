import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Input_Email.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_Forget_Pass.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/GeneratedLogupWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Input_Password.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/GeneratedLoginWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_dangNhap.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';

import '../../../reusable_widget/Title.dart';
import '../../../reusable_widget/Input.dart';
import 'package:flutterapp/setting.dart';

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
                child: whale(),
              ),
              Positioned(
                top: width * 5 / 100,
                child: title("ĐĂNG NHẬP"),
              ),
              Positioned(
                left: 102.0,
                top: width * 15 / 100,
                right: null,
                bottom: null,
                width: 60.0,
                height: 60.0,
                child: Insta(),
              ),
              Positioned(
                left: 197.0,
                top: width * 15 / 100,
                right: null,
                bottom: null,
                width: 60.0,
                height: 60.0,
                child: Twitter(),
              ),
              Positioned(
                left: 292.0,
                top: width * 15 / 100,
                right: null,
                bottom: null,
                width: 60.0,
                height: 60.0,
                child: Google(),
              ),
              Positioned(
                left: 7.0,
                top: width * 15 / 100,
                right: null,
                bottom: null,
                width: 60.0,
                height: 60.0,
                child: Facebook(),
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
                child: Input(
                  'Mật khẩu của bạn',
                  _password,
                  password,
                  context
                ),
              ),
              Positioned(
                top: width * 82 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: GeneratedLogupWidget(),
              ),
              Positioned(
                top: width * 35 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input_Email(),
              ),
              Positioned(
                left: width / 8,
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
                child: GeneratedLoginWidget(),
              ),
            ]),
      ),
    ));
  }
}
