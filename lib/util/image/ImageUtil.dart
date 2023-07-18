import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class ImageUtil {
  static ImageUtil? _instance;

  factory ImageUtil() {
    if(_instance == null) {
      _instance = ImageUtil._internal();
      return _instance!;
    }
    return _instance!;
  }

  ImageUtil._internal();

  static Future<ui.Image> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = new AssetImage(path);
    img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }


}