import 'dart:ui';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {

  const Test ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  FragmentProgram? program;
  late AnimationController _controller;
  late Animation animation;

  TestState();

  @override
  Widget build(BuildContext context) {
    Widget child = program == null ? Container() : CustomPaint(
      painter: TestPainter(program!.fragmentShader(), animation.value),
    );
    return Container(
        child: child
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 10)
    );
    animation = Tween<double>(begin: -3.14, end: 3.14)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) _controller.repeat(reverse: true);
      });
    _controller.stop();
    FragmentProgram.fromAsset("assets/shaders/background.glsl").then((value) {
      setState(() {
        program = value;
      });
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

class TestPainter extends CustomPainter {
  FragmentShader shader;
  double? time;

  TestPainter(this.shader, this.time);

  void updateShader(FragmentShader shader, double time, Size size) {
    shader.setFloat(0, time); //time

    shader.setFloat(1, size.width); // size
    shader.setFloat(2, size.height);//


  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    updateShader(shader, time!, size);

    canvas.drawRect(rect, Paint()..shader = this.shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //if(this.shader == (oldDelegate as TestPainter).shader && this.time == (oldDelegate).time) return false;
    return true;
  }

}
