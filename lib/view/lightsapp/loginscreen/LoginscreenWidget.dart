import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/util/Preferences.dart';
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
import 'package:flutterapp/reusable_widget/toast.dart';

class GeneratedLoginscreenWidget extends StatefulWidget {
  @override
  State<GeneratedLoginscreenWidget> createState() =>
      _GeneratedLoginscreenWidgetState();
}

class _GeneratedLoginscreenWidgetState
    extends State<GeneratedLoginscreenWidget> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
    var height = Setting.getHeightSize();

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
                    validate: (_password) {},
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
                    validate: (_email) {},
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
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        Map data = {
                          "email": _email.text,
                          "password": _password.text,
                        };
                        var response = await Api().postData("login", data);
                        if (response?["message"]) {
                          ToastNoti.show("Đăng nhập thành công");
                          await Preferences.setId(response?["user"]["_id"]);
                          await Preferences.setUsername(response?["user"]["name"]);
                          await Preferences.setEmail(response?["user"]["email"]);
                          await Preferences.setPhoneNumber(response?["user"]["phoneNumber"]);
                          await Preferences.setDOB(response?["user"]["DOB"]);
                          await Preferences.setAddress(response?["user"]["address"]);
                          Navigator.pushNamed(
                              context, '/GeneratedMainScreenWidget');
                        } else {
                          ToastNoti.show("Sai email hoặc mật khẩu");
                        }
                      } else {
                        ToastNoti.show("Có lỗi");
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
