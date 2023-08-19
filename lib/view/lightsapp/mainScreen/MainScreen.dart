import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/reusable_widget/vux/buttom/template.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/daily_task.dart';
import 'package:flutterapp/reusable_widget/vux/unread_indicator.dart';
import 'package:flutterapp/reusable_widget/whale.dart';

import '../../../reusable_widget/vux/listview/noti/notification_menu.dart';

class GeneratedMainScreenWidget extends StatelessWidget {
  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
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
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Template(
                  width: 50,
                  height: 50,
                  onPress: () {
                    showOverlay(context);
                  },
                  icon: MyFlutterIcon.bell,
                ),
                Positioned(
                  child: UnreadIndicator(
                    height: 20,
                    width: 20,
                  ),
                  top: -10,
                  right: -10,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Template(
            width: 50,
            height: 50,
            onPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => DailyTaskProxy());
            },
            icon: MyFlutterIcon.list_alt,
          ),
        ],
      ),
    );
  }

  void showOverlay(BuildContext context) {
    OverlayState? state = Overlay.of(context);
    if(_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => NotificationMenu(removeOverlayCallback: this.removeOverlay,),
    );
    state.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
