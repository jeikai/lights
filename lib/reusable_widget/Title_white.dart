import 'package:flutter/material.dart';

Text title(String title) {
  return Text(
    title,
    overflow: TextOverflow.visible,
    textAlign: TextAlign.center,
    style: TextStyle(
      height: 1.3960000088340359,
      fontSize: 30.0,
      fontFamily: 'Paytone One',
      fontWeight: FontWeight.w300,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );
}
