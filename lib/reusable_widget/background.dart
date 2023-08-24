import 'package:flutter/material.dart';
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

class BackGroundMainScreen extends StatelessWidget {
  final Widget? child;

  const BackGroundMainScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        RiveAnimation.direct(
          RiveUtil().BGONE,
          fit: BoxFit.fill,
        ),
        child ?? Container()
      ],
    );
  }
}
