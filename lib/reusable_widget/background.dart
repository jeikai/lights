import 'package:flutter/material.dart';

Container background(String link) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(link),
        fit: BoxFit.cover,
      ),
    ),
  );
}
