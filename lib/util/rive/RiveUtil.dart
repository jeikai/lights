

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveUtil {
  static RiveUtil? _instance;

  factory RiveUtil() {
    if(_instance == null) {
      print("null");
      _instance = RiveUtil._internal();
      return _instance!;
    }
    print("not null");
    return _instance!;
  }

  RiveUtil._internal();

  Future<void> setup() async {
    await rootBundle.load('assets/rive/whale.riv').then( (value) async {

      WHALE = RiveFile.import(value);
      print("load finish");
    });
  }

  late RiveFile WHALE;

}