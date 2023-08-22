import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/main_screen_body.dart';

import '../../../reusable_widget/vux/listview/noti/notification_menu.dart';
import 'menu_buttom.dart';

// ignore: must_be_immutable
class MainScreenWidget extends StatelessWidget {
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
              backgroundImage: AssetImage('assets/images/user_icon.png'),
            ),
            onPressed: () {},
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
        body: MainScreenBody(),
        floatingActionButton: MenuButtom(
          showOverlay: showOverlay,
        ));
  }

  void showOverlay(BuildContext context) {
    OverlayState? state = Overlay.of(context);
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => NotificationMenu(
        removeOverlayCallback: this.removeOverlay,
      ),
    );
    state.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
