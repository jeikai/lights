

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
    var a = rootBundle
        .load('assets/rive/whale.riv')
        .then((value) => _whale = value);
    var b =
        rootBundle.load('assets/rive/star.riv').then((value) => _star = value);
    var c = rootBundle
        .load('assets/rive/background.riv')
        .then((value) => _bg = value);
    await Future.wait([a, b, c]);
  }

  late ByteData _whale;

  late ByteData _star;

  late ByteData _bg;

  RiveFile getStar() {
    return RiveFile.import(_star);
  }

  RiveFile get WHALE {
    return RiveFile.import(_whale);
  }

  RiveFile get BG {
    return RiveFile.import(_bg);
  }
}