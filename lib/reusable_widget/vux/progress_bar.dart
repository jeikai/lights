import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  static const Color color1 = Color.fromARGB(255, 170,168,220);
  static const Color color2 = Color.fromARGB(255, 183,188,223);

  final double value;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  ProgressBar({
    required this.value,
    this.width = 400,
    this.height = 20,
    this.backgroundColor = color2,
    this.progressColor = color1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: value * width,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}