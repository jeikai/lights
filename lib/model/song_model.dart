import 'package:flutterapp/services/api.dart';
import 'dart:convert'; // Thêm import này

class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

}
