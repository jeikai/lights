import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.text, required this.onPress})
      : super(key: key);
  final String text;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
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
      onPressed: onPress,
      child: Text(text),
    );
  }
}

