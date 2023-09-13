import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

Container background(String link) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(link),
        fit: BoxFit.cover,
      ),
    ),
  );
}

class BackGroundFavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image(
          image: AssetImage(
              "assets/images/e283b33ab7375327428a58bc4d7aa0f81936911c.png"),
          fit: BoxFit.fill,
        ),
        Positioned(
          child: Whale(),
          bottom: size.height * 0.13,
        ),
        Container(
          color: Colors.white.withOpacity(0.5),
        )
      ],
    );
  }
}

class BackGroundMainScreen extends StatelessWidget {
  final Widget? child;

  const BackGroundMainScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        RiveAnimation.direct(
          RiveUtil.BGONE,
          fit: BoxFit.fill,
        ),
        child ?? Container()
      ],
    );
  }
}
