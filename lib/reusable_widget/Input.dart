import 'package:flutter/material.dart';

TextField Input(String placeholder, _textController, data, context) {
  return (TextField(
      keyboardType: TextInputType.emailAddress,
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
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _textController.clear();
          },
          icon: const Icon(Icons.clear),
        ),
        hintStyle: TextStyle(
          color: Color.fromRGBO(172, 193, 254, 1.0),
        ),
      )));
}
