import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/Input.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/setting.dart';
import '../../../reusable_widget/Title_dark.dart';
import '../../../util/Preferences.dart';

class GeneratedForgotpasswordscreen2Widget extends StatefulWidget {
  @override
  State<GeneratedForgotpasswordscreen2Widget> createState() =>
      _GeneratedForgotpasswordscreen2WidgetState();
}

class _GeneratedForgotpasswordscreen2WidgetState
    extends State<GeneratedForgotpasswordscreen2Widget> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _repass = TextEditingController();
  bool obscure = true;
  bool re_obscure = true;
  String id = "";

  @override
  void initState() {
    super.initState();
    id = Preferences.getForgetId()!;
  }

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _repass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
    var height = Setting.getHeightSize();
    final screenWidth = MediaQuery.of(context).size.width;
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
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: screenWidth * 0.07,
                        ),
                      ),
                    ),
                    Positioned(
                      top: width * 5 / 100,
                      child: title("BẠN QUÊN \n MẬT KHẨU?"),
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
                      top: width * 40 / 100,
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
                      top: width * 70 / 100,
                      right: null,
                      bottom: null,
                      width: 326.0,
                      height: 71.0,
                      child: Button(
                        text: 'Hoàn tất',
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_password.text.isEmpty ||
                                _repass.text.isEmpty) {
                              ToastNoti.show("Không được để trống");
                            } else if (_password.text != _repass.text) {
                              ToastNoti.show(
                                  "Mật khẩu nhập lại phải khớp với mật khẩu đã nhập");
                            } else {
                              Map data = {
                                "userId": id,
                                "password": _password.text,
                              };
                              var response = await Api()
                                  .postData("user/updatePassword", data);
                              if (response?["status"]) {
                                ToastNoti.show("Cập nhập mật khẩu thành công");
                                Navigator.pushNamed(
                                    context, '/GeneratedLoginscreenWidget');
                              } else {
                                ToastNoti.show("Không thể cập nhập mật khẩu");
                              }
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
        ));
  }
}
