import 'package:flutter/material.dart';

TextButton Button_Navigate(String text, context, String navigate_to) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Color.fromRGBO(196, 160, 216, 1.0),
      foregroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      textStyle: TextStyle(
        height: 1.396000067392985,
        fontSize: 24.0,
        fontFamily: 'Paytone One',
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.white, width: 4.0),
      ),
    ),
    onPressed: () {
      Navigator.pushNamed(context, navigate_to);
    },
    child: Text(text),
  );
}
