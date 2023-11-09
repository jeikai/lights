import 'dart:math';

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
import 'package:flutterapp/view/lightsapp/loginscreen/component/Text_Forget_Pass.dart';

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
  bool isRuntimered = false;

  Future<void> runTimer(BuildContext context) async {
    print('Run checking local login data:');
    // await Future.delayed(Duration(seconds: 1));
    if (Preferences.getId() != null &&
        Preferences.getId() != '' &&
        Preferences.getEmail() != null &&
        Preferences.getEmail() != '') {
      print('There are local login data found!');
      await Preferences.setupUser(Preferences.getId()!);
      print('Successfully setup user!');
      Navigator.pushReplacementNamed(context, '/GeneratedMainScreenWidget');
    } else {
      print("There is no local login data");
    }
  }

  String getRandomPicture() {
    List<String> pictureList = [
      "ava1.jpg",
      "ava2.jpg",
      "ava3.jpg",
      "ava4.jpg",
      "ava5.jpg",
      "ava6.jpg"
    ];
    final Random random = Random();
    final int randomIndex = random.nextInt(pictureList.length);
    return pictureList[randomIndex];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isRuntimered) {
      runTimer(context);
      isRuntimered = true;
    }
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
                  top: width * 40 / 100,
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
                  top: width * 72 / 100,
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
                  top: width * 25 / 100,
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
                  top: width * 50 / 100,
                  right: null,
                  bottom: null,
                  width: 200.0,
                  height: 33.0,
                  child: Text_Quen(),
                ),
                Positioned(
                  top: width * 60 / 100,
                  right: null,
                  bottom: null,
                  width: 326.0,
                  height: 71.0,
                  child: Button(
                    text: 'Đăng nhập',
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
                        Map data = {
                          "email": _email.text,
                          "password": _password.text,
                        };
                        var response = await Api().postData("login", data);
                        if (response?["message"]) {
                          await Preferences.setId(response?["user"]["_id"]);
                          print("setUN");
                          await Preferences.setUsername(
                              response?["user"]["name"]);
                          print("setEmail");
                          await Preferences.setEmail(
                              response?["user"]["email"]);
                          print("setPN");
                          await Preferences.setPhoneNumber(
                              response?["user"]["phoneNumber"]);
                          print("setDOB");
                          await Preferences.setDOB(response?["user"]["DOB"]);
                          print("setAddress");
                          await Preferences.setAddress(
                              response?["user"]["address"]);
                          print("setupUser");
                          await Preferences.setupUser(response?["user"]["_id"]);
                          await Preferences.setAva(getRandomPicture());
                          ToastNoti.show("Đăng nhập thành công");
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, '/GeneratedMainScreenWidget');
                        } else {
                          Navigator.pop(context);
                          ToastNoti.show("Sai email hoặc mật khẩu");
                        }
                      } else {
                        Navigator.pop(context);
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
