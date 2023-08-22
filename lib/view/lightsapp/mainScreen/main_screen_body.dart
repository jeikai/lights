import 'package:flutter/material.dart';

import '../../../reusable_widget/background.dart';
import '../../../reusable_widget/whale.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackGroundMainScreen(
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Whale(
                isClickable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
