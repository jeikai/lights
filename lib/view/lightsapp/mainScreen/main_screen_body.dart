import 'package:flutter/material.dart';
import 'package:flutterapp/util/TutorialHighlighterWidget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/blue_planet_navigate.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/red_planet_navigate.dart';

import '../../../reusable_widget/background.dart';
import '../../../reusable_widget/whale.dart';

class MainScreenBody extends StatelessWidget {
  final void Function(BuildContext context, bool isReverse) redPlanetClick;
  final void Function(BuildContext context, bool isReverse) bluePlanetClick;

  const MainScreenBody(
      {Key? key, required this.redPlanetClick, required this.bluePlanetClick})
      : super(key: key);

  void onClick1(BuildContext context) {
    //print("clicked");
    redPlanetClick(context, false);
  }

  void onClick2(BuildContext context) {
    //print("clicked");
    bluePlanetClick(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundMainScreen(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: TutorialHighlighterWidget(
              child: BluePlanetNavigate(
                onClick: onClick2,
              ),
              showCondition: () => first,
              positionX: 200,
              positionY: 180,
              height: 70,
              width: 200,
              tutorialKey: "blue_planet",
              tutorialText: "Click here to see the blue planet",
            ),
            top: -50,
            right: -100,
          ),
          Positioned(
            child: TutorialHighlighterWidget(
              child: RedPlanetNavigate(
                onClick: onClick1,
              ),
              showCondition: () => first,
              positionX: 50,
              positionY: 700,
              height: 70,
              width: 200,
              tutorialKey: "red_planet",
              tutorialText: "Click here to see the red planet",
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

bool first = true;
