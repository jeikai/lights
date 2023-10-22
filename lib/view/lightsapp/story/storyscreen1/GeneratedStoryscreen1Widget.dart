import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/whale.dart';
import 'package:flutterapp/view/lightsapp/story/storyscreen1/generated/GeneratedHycngLightsTonnnhngiukdiunhWidget.dart';

class GeneratedStoryscreen1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
        child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/Form'),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Container(
          width: 360.0,
          height: 800.0,
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              //overflow: Overflow.visible,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.asset(
                    "assets/images/3890c3231620d942b721643b360ba38e7aa00362.png",
                    color: null,
                    fit: BoxFit.cover,
                    width: 360.0,
                    height: 800.0,
                    colorBlendMode: BlendMode.dstATop,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 55),
                    child: SizedBox(
                        width: 207.0,
                        height: 105.0,
                        child: GeneratedHycngLightsTonnnhngiukdiunhWidget()),
                  ),
                ),
                SizedBox(
                  height: size.height,
                  child: Whale(
                    type: WhaleType.ANI_ONE,
                    isClickable: false,
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
