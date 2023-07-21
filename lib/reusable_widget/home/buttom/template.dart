import 'dart:js_interop';

import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  Widget? child;
  double? scaleValue;
  final VoidCallback? onPress;

  Template({Key? key, ImageProvider? image, String? text, IconData? icon, Color? inner_color, Color? bg_color, double? width = 100, double? height = 100, this.scaleValue, this.onPress}) : super(key: key) {
    if(image != null) {
      child = Container(
        width: width,
        height: height,
        child: Image(image: image),
      );
    } else if (text != null && child.isUndefinedOrNull) {
      child = Container(
        width: width,
        height: height,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0), // Add the desired margin
            child: Text(text,
              style: TextStyle(
                  color: inner_color ?? Colors.blueGrey
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: bg_color ?? Colors.white, // Set the transparent gray color
          borderRadius: BorderRadius.circular(6.0), // Set the desired border radius
        ),
      );
    } else if (icon != null && child.isUndefinedOrNull) {
      child = Container(
          width: width,
          height: height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0), // Add the desired margin
              child: Icon(
                  icon,
                  color: inner_color ?? Colors.blueGrey
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: bg_color ?? Colors.white, // Set the transparent gray color
            borderRadius: BorderRadius.circular(6.0), // Set the desired border radius
          )
      );
    } else if (child.isUndefinedOrNull) {
      child = Container(
          width: width,
          height: height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0), // Add the desired margin
              child: Icon(
                Icons.access_alarm,
                color: inner_color ?? Colors.blueGrey,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: bg_color ?? Colors.white, // Set the transparent gray color
            borderRadius: BorderRadius.circular(6.0), // Set the desired border radius
          )
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TemplateButton(
        onPressed: onPress ?? () {
          print("press");
        },
        child: child!,
        scaleValue: scaleValue ?? 1.5,
      ),
    );
  }
}

class TemplateButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double scaleValue;
  TemplateButton({required this.onPressed, required this.child, required this.scaleValue});

  @override
  _TemplateButtonState createState() => _TemplateButtonState();
}

class _TemplateButtonState extends State<TemplateButton>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  _TemplateButtonState();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: widget.scaleValue).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}



