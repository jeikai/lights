import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _name.dispose();
    _phoneNumber.dispose();
    _address.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
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
                  child: title("ĐĂNG KÝ"),
                ),
                Positioned(
                  top: width * 20 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Input(
                    textController: _name,
                    placeholder: "Tên của bạn",
                    keyboardType: TextInputType.name,
                    validate: (_name) {
                      return null;
                    },
                    obscureText: false,
                    onDataChanged: (value) => {},
                    icon: IconButton(
                      onPressed: () {
                        _name.clear();
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
                    textController: _phoneNumber,
                    placeholder: "Số điện thoại của bạn",
                    keyboardType: TextInputType.phone,
                    validate: (_phoneNumber) {
                      return null;
                    },
                    obscureText: false,
                    onDataChanged: (value) => {},
                    icon: IconButton(
                      onPressed: () {
                        _phoneNumber.clear();
                      },
                      icon: const Icon(Icons.clear),
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
                    textController: _email,
                    placeholder: "Email của bạn",
                    keyboardType: TextInputType.emailAddress,
                    validate: (_email) {
                      return null;
                    },
                    obscureText: false,
                    onDataChanged: (value) => {},
                    icon: IconButton(
                      onPressed: () {
                        _email.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                Positioned(
                  top: width * 50 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Input(
                    textController: _address,
                    placeholder: "Địa chỉ của bạn",
                    keyboardType: TextInputType.streetAddress,
                    validate: (_address) {
                      return null;
                    },
                    obscureText: false,
                    onDataChanged: (value) => {},
                    icon: IconButton(
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
                        if (_formKey.currentState!.validate()) {
                          if (_name.text.isEmpty) {
                            ToastNoti.show("Tên của bạn không được để trống");
                          } else if (_phoneNumber.text.isEmpty ||
                              _phoneNumber.text.length != 10) {
                            ToastNoti.show("Số điện thoại không hợp lệ");
                          } else if (_email.text.isEmpty ||
                              !_email.text.contains("@")) {
                            ToastNoti.show("Email không hợp lệ");
                          } else if (_address.text.isEmpty) {
                            ToastNoti.show("Địa chỉ không hợp lệ");
                          } else {
                            Map data = {"email": _email.text};
                            var checkEmail =
                                await Api().postData("user/checkEmail", data);
                            print(checkEmail);
                            if (checkEmail?["exists"] == true) {
                              ToastNoti.show("Email này đã tồn tại");
                            } else {
                              await Preferences.setRegisUsername(_name.text);
                              await Preferences.setRegisPhonenumber(
                                  _phoneNumber.text);
                              await Preferences.setRegisEmail(_email.text);
                              await Preferences.setRegisAddress(_address.text);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/GeneratedLogupscreen2Widget');
                            }
                          }
                        }
                      }),
                ),
              ]),
        ),
      ),
    ));
  }
}
