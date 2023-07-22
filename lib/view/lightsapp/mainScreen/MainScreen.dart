import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/home/buttom/template.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedMissionWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedHeaderWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedSettingWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedHomeWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/Generated811Widget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/generated/GeneratedNotiWidget.dart';
import 'package:flutterapp/setting.dart';

class GeneratedMainScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = setting.getWidthSize();
    var height = setting.getHeightSize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 241, 255),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/images/user_icon.png'), 
          ),
          onPressed: () {
            
          },
        ),
        title: Text(
          'light s',
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.6,
            fontSize: 30.0,
            fontFamily: 'Mistrully',
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 195, 160, 212),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            background(
                "assets/images/85467c0186aa1e39f7aba60db02bf4fe6c044214.png"),
            Align(
              alignment: Alignment.center,
              child: Whale(),
            ),
          ],
        ),
      ),
      floatingActionButton:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Template(
            width: 50,
            height: 50,
            onPress: null,
            icon: MyFlutterIcon.home,
          ),
          SizedBox(width: 16),
          Template(
            width: 50,
            height: 50,
            onPress: null,
            icon: MyFlutterIcon.bell,
          ),
          SizedBox(width: 16),
          Template(
            width: 50,
            height: 50,
            onPress: null,
            icon: MyFlutterIcon.rectangle_list,
          ),
        ],
      ),
    );
    // Material(
    //   child: Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     child: Stack(
    //         fit: StackFit.expand,
    //         alignment: Alignment.center,
    //         //overflow: Overflow.visible,
    //         children: [
    //           background(
    //               "assets/images/85467c0186aa1e39f7aba60db02bf4fe6c044214.png"),
    //           Positioned(
    //             top: width * 30 / 100,
    //             right: null,
    //             bottom: null,
    //             width: 273.0,
    //             height: 450.0,
    //             child: Whale(),
    //           ),
    //           Positioned(
    //             left: 118.0,
    //             top: 719.0,
    //             right: null,
    //             bottom: null,
    //             width: 57.0,
    //             height: 57.0,
    //             child: GeneratedHomeWidget(),
    //           ),
    //           Positioned(
    //             left: 199.0,
    //             top: 719.0,
    //             right: null,
    //             bottom: null,
    //             width: 57.0,
    //             height: 57.0,
    //             child: GeneratedNotiWidget(),
    //           ),
    //           Positioned(
    //             left: 280.0,
    //             top: 719.0,
    //             right: null,
    //             bottom: null,
    //             width: 57.0,
    //             height: 57.0,
    //             child: GeneratedMissionWidget(),
    //           ),
    //           Positioned(
    //             left: 0.0,
    //             top: 0.0,
    //             right: null,
    //             bottom: null,
    //             width: 360.0,
    //             height: 52.0,
    //             child: GeneratedHeaderWidget(),
    //           ),
    //           Positioned(
    //             left: 11.0,
    //             top: 10.0,
    //             right: null,
    //             bottom: null,
    //             width: 38.0,
    //             height: 38.0,
    //             child: GeneratedSettingWidget(),
    //           )
    //         ]),
    //   ),
    // );
  }
}
