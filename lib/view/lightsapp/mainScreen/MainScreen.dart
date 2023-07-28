import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/home/buttom/template.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
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
  }
}
