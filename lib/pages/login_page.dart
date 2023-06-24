import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  //Khoá truy cập Form
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    //Safe Area dùng để đảm bảo giao diện không bị che bởi thanh trạng thái hay điều hướng
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        //Hiển thị tiến trình gọi API
        body: ProgressHUD(
          child: Form(key: globalFormKey, child: _loginUI(context)),
          // Xác định API có đang được gọi hay không. Nếu true thì hiện tiến trình
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          //Khoá duy nhất để đảm bảo cập nhập hiển thị tiến trình
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    //Widget cho phép cuộn nội dung
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              //Kích thước chiều rộng của thiết bị
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.grey,
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/whale.png",
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(context, "username", "Username",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "không được để trống";
            }
            return null;
          }, (onSavedVal) {
            username = onSavedVal;
          },
              borderFocusColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            //Thiết lập khoảng cách so với bên trên là 10 điểm ảnh
            padding: const EdgeInsets.only(top: 10),
            // Widget tạp input nhập gồm các tham số đầu vào:
            // context: đối tượng UI hiện tại build lên
            // "password": kiểu dữ liệu nhập vào
            // "Password": placeholder
            // hàm kiểm tra hợp lệ
            // hàm lưu giá trị
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "không được để trống";
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                borderFocusColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                // Màu của placeholder
                hintColor: Colors.pink.withOpacity(0.7),
                borderRadius: 10,
                // Trạng thái ẩn hiện của mật khẩu với biến bool khởi tạo trước đó
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ))),
          ),
        ],
      ),
    );
  }
}
