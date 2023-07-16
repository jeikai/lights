import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Navigate.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/setting.dart';

final _email = TextEditingController();
String email = '';
final _name = TextEditingController();
String name = '';
final _phoneNumber = TextEditingController();
String phoneNumber = '';
final _address = TextEditingController();
String address = '';

class GeneratedLogupscreen1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = setting.getWidthSize();
    var height = setting.getHeightSize();
    var data = {
      "name": name,
      "phone_Number": phoneNumber,
      "email": email,
      "address": address
    };
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
                top: (width / 100 - 0.5) * 15,
                child: Wrap(
                  spacing: 29,
                  children: [Insta(), Twitter(), Google(), Facebook()],
                ),
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
                child: Input('Tên của bạn', _name, name, context),
              ),
              Positioned(
                top: width * 44 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child:
                    Input('Số điện thoại', _phoneNumber, phoneNumber, context),
              ),
              Positioned(
                top: width * 56 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Email của bạn', _email, email, context),
              ),
              Positioned(
                top: width * 68 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input('Địa chỉ của bạn', _address, address, context),
              ),
              Positioned(
                top: width * 82 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate("Tiếp theo", context, '/GeneratedLogupscreen2Widget'),
              ),
            ]),
      ),
    ));
  }
}
