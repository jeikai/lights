import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/animated_switcher_with_preload_main_screen.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/MainScreen.dart';
import 'package:flutterapp/view/lightsapp/whaleMenu/whale_menu_bubble_bar.dart';
import 'package:rive/rive.dart';

class WhaleMenu extends StatelessWidget {
  static GlobalKey<AnimatedWaitingPreloadMainScreenState> aniKey = GlobalKey();

  final RiveFile bg = RiveUtil.BGONE;
  final RiveFile whale = RiveUtil.WHALE;

  static const Color color = Color.fromARGB(255, 232, 202, 233);

  WhaleMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Material(
          child: AnimatedWaitingPreloadMainScreen(
            duration: Duration(milliseconds: 500),
            mainChildBuilder: (context) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  RiveAnimation.direct(
                    bg,
                    artboard: 'bg2',
                    fit: BoxFit.fitHeight,
                  ),
                  Positioned(
                    child: Whale(
                      type: WhaleType.ANI_ONE,
                    ),
                    bottom: height * 0.1,
                  ),
                  WhaleMenuBubbleBar(
                    children: [
                      WhaleMenuBubble(
                        child: Container(
                          color: Colors.white,
                        ),
                        onClick: (context) {
                          print("a");
                        },
                      ),
                      WhaleMenuBubble(
                        child: Container(color: Colors.black),
                      ),
                      WhaleMenuBubble(
                        child: Container(color: Colors.red),
                      )
                    ],
                  )
                ],
              );
            },
            cover: Container(
              color: color,
            ),
            delay: Duration(milliseconds: 100),
            key: aniKey,
          ),
        ),
        onWillPop: () async {
          await aniKey.currentState!.startOuttro();
          var state = MainScreenWidget.aniKey2.currentState!;
          state.widget.redPlanetClick(state.context, true);
          return true;
        });
  }
}
