import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../util/image/ImageUtil.dart';
import 'TestPainter.dart';

class Test extends StatefulWidget {

  const Test ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  ui.FragmentProgram? program;
  ui.FragmentProgram? program2;
  ui.Image? cloudsampler;
  ui.Image? glxsampler;
  late AnimationController _controller;
  late Animation animation;

  TestState();

  @override
  Widget build(BuildContext context) {
    Widget child = program == null ? Container() : CustomPaint(
      painter: TestPainter(
          program!.fragmentShader(),
          program2!.fragmentShader(),
          animation.value,
          cloudsampler!,
          glxsampler!
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

    //Todo: cleanup move to dedicated class (ShaderUtil, ImageUtil)
    print("1");
    loadShaderProgram().then((value) {
      print("7");
      setState(() {});
      _controller.forward();
    });
    //
    super.initState();
  }

  Future<void> loadTextureSampler() async {
    print("2");
    var a = ImageUtil.getImage("assets/shaders/image/2.jpg").then((value) {
      cloudsampler = value;
      print("3");
    });
    var b = ImageUtil.getImage("assets/shaders/image/3.jpg").then((value) {
      glxsampler = value;
      print("4");
    });
    await Future.wait([a,b]);
  }

  Future<void> loadShaderProgram() async {
    var c = loadTextureSampler();
    print("5");
    var a = ui.FragmentProgram.fromAsset("assets/shaders/background.glsl").then((value) {
      program = value;
    });
    var b = ui.FragmentProgram.fromAsset("assets/shaders/cloud.glsl").then((value) {
      program2 = value;
    });
    await Future.wait([a,b,c]);
    print("6");
    return;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}


