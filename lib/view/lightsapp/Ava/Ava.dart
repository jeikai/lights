import 'package:flutter/material.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/account_description_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/account_detail_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/ava_line_chart_widget.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';

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
                  title: "lịch sử hoạt động"),
              // AccountFriendsListWidget(isConfig: isConfig),
              // AvaTitleWidget(
              //   configHeight: gap * 1.5,
              //   oriHeight: gap * 1.5,
              //   isConfig: isConfig,
              //   title: "danh sách bạn bè"
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
