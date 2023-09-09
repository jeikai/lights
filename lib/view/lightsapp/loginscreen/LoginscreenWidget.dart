import 'package:flutter/material.dart';
import 'package:flutterapp/model/model_data.dart';
import 'package:flutterapp/reusable_widget/Button_Navigate.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_Forget_Pass.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/setting.dart';
import 'package:flutterapp/services/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GeneratedLoginscreenWidget extends StatefulWidget {
  @override
  State<GeneratedLoginscreenWidget> createState() =>
      _GeneratedLoginscreenWidgetState();
}

class _GeneratedLoginscreenWidgetState
    extends State<GeneratedLoginscreenWidget> {
  // Editing controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
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
                    children: [Insta(), Twitter(), Google(), Facebook()],
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
                  child: Input(
                    textController: _password,
                    placeholder: "Mật khẩu của bạn",
                    keyboardType: TextInputType.emailAddress,
                    validate: (_password) {
                      if (_password!.isEmpty || _password.length < 6) {
                        print("Mật khẩu không hợp lệ");
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
                  top: width * 82 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Button(
                    text: "Đăng ký",
                    onPress: () => {
                      Navigator.pushNamed(
                          context, '/GeneratedLogupscreen1Widget')
                    },
                  ),
                ),
                Positioned(
                  top: width * 35 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Input(
                    textController: _email,
                    placeholder: "Email của bạn",
                    keyboardType: TextInputType.emailAddress,
                    validate: (_email) {
                      if (_email!.isEmpty) {
                        print("Email không hợp lệ");
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_email)) {
                        return null;
                      } else {
                        print('Email hợp lệ');
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
                  child: Button(
                    text: 'Đăng nhập',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Map data = {
                          "email": _email.text,
                          "password": _password.text,
                        };
                        var response = Api().postData("login", data);
                        print(response);
                        // Navigator.pushNamed(
                        //     context, '/Chatbot');
                      } else {
                        print("not ok");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
