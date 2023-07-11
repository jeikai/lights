import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Title.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/LoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/setting.dart';

final _DOB = TextEditingController();
String DOB = '';
final _password = TextEditingController();
String password = '';
final _repass = TextEditingController();
String repass = '';

class GeneratedLogupscreen2Widget extends StatelessWidget {
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
                child: title("ĐĂNG KÝ"),
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
                top: width * 32 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Tuổi của bạn YYYY/MM/DD', _DOB, DOB, context),
              ),
              Positioned(
                top: width * 44 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child:
                    Input('Mật khẩu của bạn', _password, password, context),
              ),
              Positioned(
                top: width * 56 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Xác nhận mật khẩu', _repass, repass, context),
              ),
              Positioned(
                top: width * 82 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate(
                    "Tiếp theo", context, '/GeneratedFavoritescreenWidget'),
              ),
            ]),
      ),
    ));
  }
}
