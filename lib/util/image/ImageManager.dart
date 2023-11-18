import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() => _instance;

  static final String template = "assets/images/template.png";
  static final String template2 = "assets/images/template2.png";

  // static final String wb1 = "assets/images/1.svg";
  // static final String wb2 = "assets/images/2.svg";
  // static final String wb3 = "assets/images/3.svg";
  static final String wbi1 = "assets/images/1.png";
  static final String wbi2 = "assets/images/2.png";
  static final String wbi3 = "assets/images/3.png";
  static final String bluePlanet = "assets/images/blue_planet.png";

  static final String cog = "assets/images/cog-unscreen.gif";
  static final String egg = "assets/images/egg.png";

  static final String coral = "assets/images/coral_calender.png";

  static final String card = "assets/images/card.png";

  Map<String, ui.Image> _preloadedImages = {};

  Map<String, Uint8List> _preloadedByte = {};

  ImageManager._internal();

  Future<void> setup() async {
    await this.preloadImage(template);
    // await this.preloadByte(wb1);
    // await this.preloadByte(wb2);
    // await this.preloadByte(wb3);
    await this.preloadImage(wbi1);
    await this.preloadImage(wbi2);
    await this.preloadImage(wbi3);
    await this.preloadImage(bluePlanet);
    await this.preloadImage(template2);
    await this.preloadImage(cog);
    await this.preloadImage(egg);
    await this.preloadByte(coral);
    await this.preloadByte(card);
  }

  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<void> preloadImage(String imageUrl) async {
    if (!_preloadedImages.containsKey(imageUrl)) {
      final ByteData data = await rootBundle.load(imageUrl);
      _preloadedByte[imageUrl] = data.buffer.asUint8List();
      _preloadedImages[imageUrl] = await loadImage(Uint8List.view(data.buffer));
    }
  }

  Future<void> preloadByte(String imageUrl) async {
    if (!_preloadedImages.containsKey(imageUrl)) {
      final ByteData data = await rootBundle.load(imageUrl);
      _preloadedByte[imageUrl] = data.buffer.asUint8List();
    }
  }

  Uint8List? getBytes(String imageUrl) {
    return _preloadedByte[imageUrl];
  }

  ui.Image? getUIImage(String imageUrl) {
    return _preloadedImages[imageUrl];
  }
}
