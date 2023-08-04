import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Navigate.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/LoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/setting.dart';

class GeneratedLogupscreen2Widget extends StatefulWidget {
  @override
  State<GeneratedLogupscreen2Widget> createState() =>
      _GeneratedLogupscreen2WidgetState();
}

class _GeneratedLogupscreen2WidgetState
    extends State<GeneratedLogupscreen2Widget> {
  final _DOB = TextEditingController();
  final _password = TextEditingController();
  final _repass = TextEditingController();
  bool obscure = true;
  bool re_obscure = true;

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
                child: Input(
                  textController: _DOB,
                  placeholder: "Tuổi của bạn",
                  keyboardType: TextInputType.datetime,
                  validate: (_DOB) {
                    if (_DOB!.isEmpty) {
                      return "Tuổi không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      _DOB.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              Positioned(
                top: width * 44 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input(
                  textController: _password,
                  placeholder: "Mật khẩu của bạn",
                  keyboardType: TextInputType.text,
                  validate: (_password) {
                    if (_password!.isEmpty || _password.length < 6) {
                      return "password không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: obscure,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure; // Toggle the password visibility
                      });
                    },
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: width * 56 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input(
                  textController: _repass,
                  placeholder: "Nhập lại mật khẩu của bạn",
                  keyboardType: TextInputType.text,
                  validate: (_repass) {
                    if (_repass!.isEmpty || _repass != _password.text) {
                      return "Mật khẩu không trùng khớp";
                    } else {
                      return null;
                    }
                  },
                  obscureText: re_obscure,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      setState(() {
                        re_obscure = !re_obscure; // Toggle the password visibility
                      });
                    },
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: width * 82 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Button_Navigate(
                  "Tiếp theo",
                  context,
                  '/GeneratedFavoritescreenWidget',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
