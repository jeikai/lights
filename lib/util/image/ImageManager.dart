import 'package:flutter/material.dart';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() => _instance;

  static final String mainBG =
      "assets/images/85467c0186aa1e39f7aba60db02bf4fe6c044214.png";

  ImageManager._internal();

  Future<void> setup() async {
    this.preloadImage(mainBG);
  }

  Map<String, ImageProvider> _preloadedImages = {};

  void preloadImage(String imageUrl) {
    if (!_preloadedImages.containsKey(imageUrl)) {
      _preloadedImages[imageUrl] = AssetImage(imageUrl);
    }
  }

  ImageProvider getImageProvider(String imageUrl) {
    return _preloadedImages[imageUrl] ?? NetworkImage(imageUrl);
  }
}
