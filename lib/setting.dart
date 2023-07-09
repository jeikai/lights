import 'package:flutter/material.dart';

class setting {
  static var widthSize;
  static var heightSize;

  static setWidthSize(var a) {
    widthSize = a;
  }

  static setHeightSize(var b) {
    widthSize = b;
  }
  static getWidthSize() {
    return widthSize;
  }

  static getHeightSize() {
    return heightSize;
  }
}
