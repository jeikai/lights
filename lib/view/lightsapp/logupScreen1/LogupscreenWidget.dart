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

class LogupScreen extends StatefulWidget {
  @override
  State<LogupScreen> createState() => _LogupScreenState();
}

class _LogupScreenState extends State<LogupScreen> {
  final _email = TextEditingController();

  final _name = TextEditingController();

  final _phoneNumber = TextEditingController();

  final _address = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _phoneNumber.dispose();
    _address.dispose();
    super.dispose();
  }
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
                  textController: _name,
                  placeholder: "Tên của bạn",
                  keyboardType: TextInputType.name,
                  validate: (_name) {
                    if (_name!.isEmpty || _name.length > 7) {
                      return "Tên không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      _name.clear();
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
                child:
                    Input(
                  textController: _phoneNumber,
                  placeholder: "Số điện thoại của bạn",
                  keyboardType: TextInputType.emailAddress,
                  validate: (_phoneNumber) {
                    if (_phoneNumber!.isEmpty || _phoneNumber.length != 10) {
                      return "Số điện thoại không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      _phoneNumber.clear();
                    },
                    icon: const Icon(Icons.clear),
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
                  textController: _email,
                  placeholder: "Email của bạn",
                  keyboardType: TextInputType.emailAddress,
                  validate: (_email) {
                    if (_email!.isEmpty || !_email.contains("@")) {
                      return "Email không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      _email.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              Positioned(
                top: width * 68 / 100,
                right: null,
                bottom: null,
                width: 326.0,
                height: 71.0,
                child: Input(
                  textController: _address,
                  placeholder: "Địa chỉ của bạn",
                  keyboardType: TextInputType.emailAddress,
                  validate: (_address) {
                    if (_address!.isEmpty) {
                      return "Địa chỉ không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: false,
                  onDataChanged: (value) => {},
                  Icon: IconButton(
                    onPressed: () {
                      _address.clear();
                    },
                    icon: const Icon(Icons.clear),
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
                    "Tiếp theo", context, '/GeneratedLogupscreen2Widget'),
              ),
            ]),
      ),
    ));
  }
}
