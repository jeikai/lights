import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/red_planet_navigate.dart';

import '../../../reusable_widget/background.dart';
import '../../../reusable_widget/whale.dart';

class MainScreenBody extends StatelessWidget {
  final void Function(BuildContext context, bool isReverse) redPlanetClick;

  const MainScreenBody({Key? key, required this.redPlanetClick})
      : super(key: key);

  void onClick(BuildContext context) {
    //print("clicked");
    redPlanetClick(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundMainScreen(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: RedPlanetNavigate(
              onClick: onClick,
            ),
            bottom: -30,
            left: -100,
          ),
          const Align(
            alignment: Alignment.center,
            child: Whale(
              isClickable: true,
            ),
          ),
        ],
      ),
    );
  }
}
