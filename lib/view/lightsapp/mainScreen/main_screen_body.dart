import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/red_planet_navigate.dart';

import '../../../reusable_widget/background.dart';
import '../../../reusable_widget/whale.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackGroundMainScreen(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: RedPlanetNavigate(),
            bottom: -30,
            left: -100,
          ),
          Align(
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
