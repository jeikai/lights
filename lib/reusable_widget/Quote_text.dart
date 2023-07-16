import 'package:flutter/material.dart';

Text quote(String quote) {
  return Text(
    quote,
    overflow: TextOverflow.visible,
    textAlign: TextAlign.center,
    style: TextStyle(
        height: 1.3960000276565552,
        fontSize: 16.0,
        fontFamily: 'Paytone One',
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 75, 88, 159),

      /* letterSpacing: 0.0, */
    ),
  );
}