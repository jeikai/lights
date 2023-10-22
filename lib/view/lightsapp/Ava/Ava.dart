import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/account_description_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/account_detail_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/ava_line_chart_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ava extends StatefulWidget {
  const Ava({Key? key});

  @override
  State<Ava> createState() => _AvaState();
}

class _AvaState extends State<Ava> {
  String username = "";
  final ValueNotifier<bool> isConfig = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    username = Preferences.getUsername()!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gap = size.width * 0.06;
    double padding = size.width * 0.06;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color.fromRGBO(148, 161, 215, 1.0),
              size: 32.0,
            ),
            onPressed: () {
              var b = isConfig.value;
              isConfig.value = !b;
            },
          ),
        ],
      ),
      body: Material(
        child: Padding(
          padding: EdgeInsets.only(
            left: padding,
            right: padding,
            top: 0,
            bottom: 0,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            clipBehavior: Clip.antiAlias,
            children: [
              AccountDetailWidget(username: username, isConfig: isConfig),
              SizedBox(
                height: gap,
              ),
              AccountDescriptionWidget(padding: padding, isConfig: isConfig),
              SizedBox(
                height: gap,
              ),
              AvaLineChartWidget(isConfig: isConfig),
              AvaTitleWidget(
                  configHeight: 0,
                  oriHeight: gap * 1.5,
                  isConfig: isConfig,
                  title: "biểu đồ cảm xúc"),
              // AccountFriendsListWidget(isConfig: isConfig),
              // AvaTitleWidget(
              //   configHeight: gap * 1.5,
              //   oriHeight: gap * 1.5,
              //   isConfig: isConfig,
              //   title: "danh sách bạn bè"
              // ),
              ConfigMenuConverter(
                  configHeight: 50,
                  oriHeight: 0,
                  isConfig: isConfig,
                  color: Colors.transparent,
                  child: SizedBox(height: 0,),
                  configChild: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromRGBO(196, 160, 216, 1.0),
                      foregroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                      textStyle: TextStyle(
                        height: 1.396000067392985,
                        fontSize: 24.0,
                        fontFamily: 'Paytone One',
                        fontWeight: FontWeight.w400,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.white, width: 4.0),
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();
                      ToastNoti.show("Đăng xuất thành công");
                      Navigator.pushNamedAndRemoveUntil(context, '/GeneratedLoginscreenWidget', (Route<dynamic> route) => false);
                    },
                    child: Text('Đăng xuất'),
                  )
              ),
              ConfigMenuConverter(
                  configHeight: 50,
                  oriHeight: 0,
                  isConfig: isConfig,
                  color: Colors.transparent,
                  child: SizedBox(height: 0,),
                  configChild: SizedBox(height: gap,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
