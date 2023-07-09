import 'package:flutter/material.dart';

Text title(String title) {
  return Text(
    title,
    overflow: TextOverflow.visible,
    textAlign: TextAlign.center,
    style: TextStyle(
      height: 1.3960000088340359,
      fontSize: 38.0,
      fontFamily: 'Paytone One',
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(255, 0, 0, 0),

      /* letterSpacing: 0.0, */
    ),
  );
}
