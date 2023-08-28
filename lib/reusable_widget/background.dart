import 'package:flutter/material.dart';

import '../util/image/ImageManager.dart';

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

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ImageManager().getImageProvider(ImageManager.mainBG),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
