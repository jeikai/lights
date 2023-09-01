// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveUtil {
  static RiveUtil? _instance;

  factory RiveUtil() {
    if (_instance == null) {
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

  static RiveFile get WHALE {
    return RiveFile.import(RiveUtil()._whale);
  }

  static RiveFile get BG {
    return RiveFile.import(RiveUtil()._bg);
  }

  static RiveFile? _bgOne;

  static RiveFile get BGONE {
    if (_bgOne == null) _bgOne = BG;
    return _bgOne!;
  }
}
