import 'package:flutter/material.dart';

double calcHeight(String text, TextStyle style, double maxWidth) {
  TextSpan textSpan = TextSpan(text: text, style: style);
  TextPainter textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(maxWidth: maxWidth);
  return textPainter.height;
}
