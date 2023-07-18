import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TestPainter extends CustomPainter {
  ui.FragmentShader bg_shader;
  ui.FragmentShader c_shader;
  double time;
  ui.Image cloudsampler;
  ui.Image glxsampler;

  TestPainter(this.bg_shader, this.c_shader, this.time, this.cloudsampler, this.glxsampler);

  void updateShader(double time, Size size, ui.Image image, ui.Image image2) {
    //bg_shader
    bg_shader.setFloat(0, time); //time

    bg_shader.setFloat(1, size.width); // size
    bg_shader.setFloat(2, size.height);//

    //c_shader
    c_shader.setFloat(0, time); //time

    c_shader.setFloat(1, size.width); // size
    c_shader.setFloat(2, size.height);//
    c_shader.setImageSampler(0, image); // cloudsampler
    c_shader.setImageSampler(1, image2);// glxsampler
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    updateShader(time, size, cloudsampler, glxsampler);

    canvas.drawRect(rect, Paint()..shader = this.c_shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //if(this.shader == (oldDelegate as TestPainter).shader && this.time == (oldDelegate).time) return false;
    return true;
  }

}