import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/setting.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:intl/intl.dart';

class GeneratedLogupscreen2Widget extends StatefulWidget {
  @override
  State<GeneratedLogupscreen2Widget> createState() =>
      _GeneratedLogupscreen2WidgetState();
}

class _GeneratedLogupscreen2WidgetState
    extends State<GeneratedLogupscreen2Widget> {
  final _dob = TextEditingController();
  final _password = TextEditingController();
  final _repass = TextEditingController();
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();

  bool reObscure = true;
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
    name = Preferences.getRegisUsername();
    email = Preferences.getRegisEmail();
    phoneNumber = Preferences.getRegisPhonenumber();
    address = Preferences.getRegisAddress();
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
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
                    top: width * 20 / 100,
                    right: null,
                    bottom: null,
                    width: 326.0,
                    height: 71.0,
                    child: Input(
                      textController: _dob,
                      placeholder: "Ngày sinh DD/MM/YYYY",
                      keyboardType: TextInputType.datetime,
                      validate: (_dob) {
                        return null;
                      },
                      obscureText: false,
                      onDataChanged: (value) => {},
                      icon: IconButton(
                        onPressed: () {
                          _dob.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  Positioned(
                    top: width * 30 / 100,
                    right: null,
                    bottom: null,
                    width: 326.0,
                    height: 71.0,
                    child: Input(
                      textController: _password,
                      placeholder: "Mật khẩu của bạn",
                      keyboardType: TextInputType.text,
                      validate: (_password) {
                        return null;
                      },
                      obscureText: obscure,
                      onDataChanged: (value) => {},
                      icon: IconButton(
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
                    top: width * 40 / 100,
                    right: null,
                    bottom: null,
                    width: 326.0,
                    height: 71.0,
                    child: Input(
                      textController: _repass,
                      placeholder: "Nhập lại mật khẩu của bạn",
                      keyboardType: TextInputType.text,
                      validate: (_repass) {
                        return null;
                      },
                      obscureText: reObscure,
                      onDataChanged: (value) => {},
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            reObscure =
                                !reObscure; // Toggle the password visibility
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  onWillPop: () async => false);
                            });
                        try {
                          if (_formKey.currentState!.validate()) {
                            if (_dob.text.isEmpty ||
                                _password.text.isEmpty ||
                                _repass.text.isEmpty) {
                              ToastNoti.show("Không được để trống");
                            } else if (_password.text != _repass.text) {
                              ToastNoti.show(
                                  "Mật khẩu nhập lại phải khớp với mật khẩu đã nhập");
                            } else if (!isValidDOB(_dob.text)) {
                              ToastNoti.show("Ngày sinh không hợp lệ. Ví dụ: 01/01/2000");
                            } else {
                              Map data = {
                                "email": email,
                                "name": name,
                                "password": _password.text,
                                "phoneNumber": phoneNumber,
                                "DOB": _dob.text,
                                "address": address
                              };
                              print(data);
                              var response =
                                  await Api().postData("register", data);
                              Map data2 = {"userId": response?["user"]["_id"]};
                              var response2 =
                                  await Api().postData("regisCard", data2);
                              if (response?["user"]["_id"] != null &&
                                  response2?["message"] == 'Success') {
                                await Preferences.setId(
                                    response?["user"]["_id"]);
                                await Preferences.setUsername(
                                    response?["user"]["name"]);
                                await Preferences.setEmail(
                                    response?["user"]["email"]);
                                await Preferences.setPhoneNumber(
                                    response?["user"]["phoneNumber"]);
                                await Preferences.setDOB(
                                    response?["user"]["DOB"]);
                                await Preferences.setAddress(
                                    response?["user"]["address"]);
                                Preferences.setupUser(response?["user"]["_id"]);
                                ToastNoti.show("Đăng ký thành công");
                                Navigator.pop(context);
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
