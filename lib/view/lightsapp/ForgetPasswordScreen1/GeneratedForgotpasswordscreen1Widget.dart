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

class GeneratedForgotpasswordscreen1Widget extends StatefulWidget {
  @override
  State<GeneratedForgotpasswordscreen1Widget> createState() => _GeneratedForgotpasswordscreen1WidgetState();
}

class _GeneratedForgotpasswordscreen1WidgetState extends State<GeneratedForgotpasswordscreen1Widget> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _phoneNo = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _phoneNo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Setting.getWidthSize();
    var height = Setting.getHeightSize();
    final screenWidth = MediaQuery.of(context).size.width;

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
                  top: width * 50 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Input(
                    textController: _phoneNo,
                    placeholder: "Số điện thoại của bạn",
                    keyboardType: TextInputType.phone,
                    validate: (_email) {
                      return null;
                    },
                    obscureText: false,
                    onDataChanged: (value) => {},
                    Icon: IconButton(
                      onPressed: () {
                        _phoneNo.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
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
                      return null;
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
                  top: width * 70 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Button(
                    text: 'Xác nhận',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        Map data = {
                          "email": _email.text,
                          "phoneNumber": _phoneNo.text,
                        };
                        var response = await Api().postData(
                            "user/checkEmailAndPhone", data);
                        if(response?["status"]) {
                          await Preferences.setForgetId(response?["user"]["_id"]);
                          Navigator.pushNamed(
                              context, '/GeneratedForgotpasswordscreen2Widget');
                          print(response?["user"]);
                        } else {
                          ToastNoti.show("Email hoặc số điện thoại không tồn tại");
                        }
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
