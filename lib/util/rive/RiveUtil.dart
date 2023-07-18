

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveUtil {
  static RiveUtil? _instance;

  factory RiveUtil() {
    if(_instance == null) {
      _instance = RiveUtil._internal();
      return _instance!;
    }
    return _instance!;
  }

  RiveUtil._internal();

  Future<void> setup() async {
    var a = rootBundle.load('assets/rive/whale.riv').then( (value) async {
      WHALE = RiveFile.import(value);
    });
    Future.wait([a]);
  }

  late RiveFile WHALE;

}