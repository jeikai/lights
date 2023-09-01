import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() => _instance;

  static final String template = "assets/images/template.png";

  ImageManager._internal();

  Future<void> setup() async {
    this.preloadImage(template);
  }

  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Map<String, ui.Image> _preloadedImages = {};

  void preloadImage(String imageUrl) async {
    if (!_preloadedImages.containsKey(imageUrl)) {
      final ByteData data = await rootBundle.load(imageUrl);
      _preloadedImages[imageUrl] = await loadImage(Uint8List.view(data.buffer));
    }
  }

  ui.Image? getUIImage(String imageUrl) {
    return _preloadedImages[imageUrl];
  }
}
