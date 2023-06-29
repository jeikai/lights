import 'package:flutter/material.dart';

/* Rectangle egg 1
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedEgg1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/GeneratedHelloscreenWidget'),
      child: Container(
        width: 390.0,
        height: 462.0,
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.asset(
            "assets/images/5dc9df605c64834da1cf2c1d967a87e4eae2f226.png",
            color: null,
            fit: BoxFit.cover,
            width: 260.0,
            height: 308.0,
            colorBlendMode: BlendMode.dstATop,
          ),
        ),
      ),
    );
  }
}