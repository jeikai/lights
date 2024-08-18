import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.textController,
    required this.placeholder,
    required this.validate,
    required this.keyboardType,
    required this.onDataChanged,
    required this.icon,
    required this.obscureText,
    this.inputFormatters = const [],
  }) : super(key: key);

  final TextEditingController textController;
  final String placeholder;
  final String? Function(String?)? validate;
  final TextInputType keyboardType;
  final Function(String) onDataChanged;
  final Widget? icon;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        style: TextStyle(
          color: Color.fromRGBO(135, 161, 209, 1.0),
          fontSize: 20.0,
          fontFamily: 'Paytone One',
          fontWeight: FontWeight.w400,
        ),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onTapOutside: (event) => {FocusScope.of(context).unfocus()},
        controller: textController,
        validator: validate,
        enableSuggestions: true,
        onChanged: onDataChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: placeholder,
          suffixIconColor: Color.fromRGBO(172, 193, 254, 1.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: icon,
          hintStyle: TextStyle(
            color: Color.fromRGBO(135, 161, 209, 1.0),
            fontSize: 20.0,
            fontFamily: 'Paytone One',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}