import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/whaleMenu/whale_menu_bubble_bar.dart';
import 'package:rive/rive.dart';

class WhaleMenu extends StatelessWidget {
  final RiveFile bg = RiveUtil.BGONE;
  final RiveFile whale = RiveUtil.WHALE;

  WhaleMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
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
      ),
    );
  }
}
