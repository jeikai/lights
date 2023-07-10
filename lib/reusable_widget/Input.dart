import 'package:flutter/material.dart';

TextField Input(String placeholder, _textController, data, context) {
  return (TextField(
      style: TextStyle(
        color: Color.fromRGBO(135, 161, 209, 1.0),
        fontSize: 20.0,
        fontFamily: 'Paytone One',
        fontWeight: FontWeight.w400,
      ),
      keyboardType: TextInputType.text,
      onTapOutside: (event) => {FocusScope.of(context).unfocus()},
      controller: _textController,
      enableSuggestions: true,
      onChanged: (value) => {data = value},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: placeholder,
        suffixIconColor: Color.fromRGBO(172, 193, 254, 1.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _textController.clear();
          },
          icon: const Icon(Icons.clear),
        ),
        hintStyle: TextStyle(
          color: Color.fromRGBO(135, 161, 209, 1.0),
          fontSize: 20.0,
          fontFamily: 'Paytone One',
          fontWeight: FontWeight.w400,
        ),
      )));
}
