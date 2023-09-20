import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/animated_switcher_with_preload_main_screen.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/main_screen_body.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/red_planet_click_animation.dart';

import '../../../reusable_widget/vux/listview/noti/notification_menu.dart';
import 'blue_planet_click_animation.dart';
import 'menu_buttom.dart';

// ignore: must_be_immutable
class MainScreenWidget extends StatelessWidget {
  static GlobalKey<AnimatedWaitingPreloadMainScreenState> aniKey = GlobalKey();
  static GlobalKey<MainScreenBodyWrapperState> aniKey2 = GlobalKey();

  final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: AnimatedWaitingPreloadMainScreen(
        key: aniKey,
        duration: Duration(milliseconds: 500),
        mainChildBuilder: (context) => _MainScreenBodyWrapper(
            key: aniKey2,
            redPlanetClick: redPlanetClick,
            bluePlanetClick: bluePlanetClick,
            showNotiOverlay: showNotiOverlay,
            avaClick: avaClick),
        cover: Container(
          color: Colors.white,
        ),
        delay: Duration(seconds: 2),
      ),
      onWillPop: () async {
        //await aniKey.currentState!.startOuttro();
        return false;
      },
    );
  }

  void avaClick(BuildContext context) {
    Navigator.pushNamed(context, "/Ava");
  }

  void bluePlanetClick(BuildContext context, bool isReverse) {
    this.showOverlay(
        context,
        (context) =>
            BluePlanetClickAnimation(context, removeOverlay, isReverse));
  }

  void redPlanetClick(BuildContext context, bool isReverse) {
    this.showOverlay(
        context,
        (context) =>
            RedPlanetClickAnimation(context, removeOverlay, isReverse));
    /*Navigator.pushNamed(context, "/WhaleMenu");*/
  }

  void showNotiOverlay(BuildContext context) {
    this.showOverlay(
        context,
        (context) => NotificationMenu(
              removeOverlayCallback: this.removeOverlay,
            ));
  }

  void showOverlay(BuildContext context, Builder builder) {
    OverlayState? state = Overlay.of(context);
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: builder,
    );
    state.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}

typedef Builder = Widget Function(BuildContext context);
typedef ShowOverlay = void Function(BuildContext context);

class _MainScreenBodyWrapper extends StatefulWidget {
  final void Function(BuildContext context, bool isReverse) redPlanetClick;
  final void Function(BuildContext context, bool isReverse) bluePlanetClick;
  final void Function(BuildContext context) showNotiOverlay;
  final void Function(BuildContext context) avaClick;

  const _MainScreenBodyWrapper(
      {required this.redPlanetClick,
      required this.bluePlanetClick,
      required this.showNotiOverlay,
      required this.avaClick,
      super.key});

  @override
  State<_MainScreenBodyWrapper> createState() => MainScreenBodyWrapperState();
}

class MainScreenBodyWrapperState extends State<_MainScreenBodyWrapper> {
  final TextStyle style = TextStyle(
    height: 1.6,
    fontSize: 30.0,
    fontFamily: 'Mistrully',
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 195, 160, 212),
  );

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
            onPressed: () => {
              // widget.avaClick
            Navigator.pushNamed(context, "/Ava")
          },
          ),
          title: Text(
            'light s',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        body: MainScreenBody(
          redPlanetClick: widget.redPlanetClick,
          bluePlanetClick: widget.bluePlanetClick,
        ),
        floatingActionButton: MenuButtom(
          showOverlay: widget.showNotiOverlay,
        ));
  }
}
