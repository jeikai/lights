import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Facebook.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Google.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Instagram.dart';
import 'package:flutterapp/reusable_widget/Logo_Brand/Twitter.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/setting.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_HoacVoi.dart';
import 'package:intl/intl.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool re_obscure = true;
  String name = "";
  String email = "";
  String phoneNumber = "";
  String address = "";

  bool isValidDOB(String dob) {
    try {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      DateTime parsedDate = dateFormat.parseStrict(dob);
      if (parsedDate.year >= 1900 &&
          parsedDate.year <= DateTime.now().year &&
          parsedDate.month >= 1 &&
          parsedDate.month <= 12 &&
          parsedDate.day >= 1 &&
          parsedDate.day <=
              DateTime(parsedDate.year, parsedDate.month + 1, 0).day) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    name = Preferences.getRegisUsername()!;
    email = Preferences.getRegisEmail()!;
    phoneNumber = Preferences.getRegisPhonenumber()!;
    address = Preferences.getRegisAddress()!;
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
    var height = Setting.getHeightSize();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
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
                      placeholder: "Ngày sinh DD/MM/YYYY",
                      keyboardType: TextInputType.datetime,
                      validate: (_DOB) {},
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
                      validate: (_password) {},
                      obscureText: obscure,
                      onDataChanged: (value) => {},
                      Icon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure =
                                !obscure; // Toggle the password visibility
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
                      validate: (_repass) {},
                      obscureText: re_obscure,
                      onDataChanged: (value) => {},
                      Icon: IconButton(
                        onPressed: () {
                          setState(() {
                            re_obscure =
                                !re_obscure; // Toggle the password visibility
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
                      text: "Tiếp theo",
                      onPress: () async {
                        try {
                          if (_formKey.currentState!.validate()) {
                            if (_DOB.text.isEmpty ||
                                _password.text.isEmpty ||
                                _repass.text.isEmpty) {
                              ToastNoti.show("Không được để trống");
                            } else if (_password.text != _repass.text) {
                              ToastNoti.show(
                                  "Mật khẩu nhập lại phải khớp với mật khẩu đã nhập");
                            } else if (!isValidDOB(_DOB.text)) {
                              ToastNoti.show("Ngày sinh không hợp lệ");
                            } else {
                              Map data = {
                                "email": email,
                                "name": name,
                                "password": _password.text,
                                "phoneNumber": phoneNumber,
                                "DOB": _DOB.text,
                                "address": address
                              };
                              print(data);
                              var response =
                                  await Api().postData("register", data);
                              print("Passed");
                              print(response);
                              if (response?["_id"] != null) {
                                ToastNoti.show("Đăng ký thành công");
                                Navigator.pushNamed(
                                  context,
                                  '/GeneratedFavoritescreenWidget',
                                );
                              } else {
                                ToastNoti.show("Đăng ký không thành công");
                              }
                            }
                          }
                        } catch (error) {
                          print("Lỗi xảy ra: $error");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
