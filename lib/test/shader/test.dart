import 'dart:ui';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<StatefulWidget> {
  FragmentProgram? program;

  @override
  Widget build(BuildContext context) {
    Widget child = program == null ? Container() : CustomPaint(
      painter: TestPainter(program!.fragmentShader()),
    );
    return Container(
        child: child
    );
  }

  @override
  void initState() {
    FragmentProgram.fromAsset("assets/shaders/background.glsl").then((value) {
      setState(() {
        program = value;
      });
    });
    super.initState();
  }

}

class TestPainter extends CustomPainter {
  FragmentShader shader;

  TestPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    canvas.drawRect(rect, Paint()..shader = this.shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
