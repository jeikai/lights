import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Test extends StatefulWidget {

  const Test ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  FragmentProgram? program;
  FragmentProgram? program2;
  Image? cloudsampler;
  late AnimationController _controller;
  late Animation animation;

  TestState();

  @override
  Widget build(BuildContext context) {
    Widget child = program == null ? Container() : CustomPaint(
      painter: TestPainter(
          program!.fragmentShader(),
          program2!.fragmentShader(),
          animation.value
      ),
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
    loadShaderProgram().then((value) {
      print("6");
      setState(() {});
      _controller.forward();
    });
    super.initState();
  }

  Future<void> loadTextureSampler() async {
    AssetImage()
  }

  Future<void> loadShaderProgram() async {
    var a = FragmentProgram.fromAsset("assets/shaders/background.glsl").then((value) {
      program = value;
    });
    var b = FragmentProgram.fromAsset("assets/shaders/cloud.glsl").then((value) {
      program2 = value;
    });
    await Future.wait([a,b]);
    return;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

class TestPainter extends CustomPainter {
  FragmentShader bg_shader;
  FragmentShader c_shader;
  double? time;

  TestPainter(this.bg_shader, this.c_shader, this.time);

  void updateShader(double time, Size size) {
    //bg_shader
    bg_shader.setFloat(0, time); //time

    bg_shader.setFloat(1, size.width); // size
    bg_shader.setFloat(2, size.height);//

    //c_shader
    c_shader.setImageSampler(index, image)
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    updateShader(time!, size);

    canvas.drawRect(rect, Paint()..shader = this.bg_shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //if(this.shader == (oldDelegate as TestPainter).shader && this.time == (oldDelegate).time) return false;
    return true;
  }

}
