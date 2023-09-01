import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutterapp/util/image/ImageManager.dart';

import '../custommenu/custom_menu.dart';

class BluePlanetClickAnimation extends StatefulWidget {
  final context;
  final void Function() remove;
  final bool isReverse;

  const BluePlanetClickAnimation(this.context, this.remove, this.isReverse,
      {Key? key})
      : super(key: key);

  @override
  _BluePlanetClickAnimationState createState() =>
      _BluePlanetClickAnimationState();
}

class _BluePlanetClickAnimationState extends State<BluePlanetClickAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late ui.Image image;

  @override
  void initState() {
    image = ImageManager().getUIImage(ImageManager.template)!;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
    if (widget.isReverse) {
      _controller.reverse(from: 1).then((value) {
        widget.remove();
        //print("pop");
      });
    } else {
      _controller.forward().then((value) {
        Navigator.pushNamed(widget.context, "/CustomMenu");
        widget.remove();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Animation<double> animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCirc);
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          size: size,
          painter: _BPCACustomPainter(animation.value, image),
        );
      },
    );
  }
}

class _BPCACustomPainter extends CustomPainter {
  final double value;
  final ui.Image image;

  _BPCACustomPainter(this.value, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Path mPath = Path();
    mPath.moveTo(size.width, 0);
    var h = size.height * value * 2;
    mPath.lineTo(size.width, h);
    mPath.arcToPoint(Offset(size.width - h, 0), radius: Radius.circular(h));
    mPath.lineTo(size.width, 0);

    //canvas.drawImage(image, Offset.zero, Paint());
    canvas.clipPath(mPath, doAntiAlias: true);

    paintImage(
        canvas: canvas,
        rect: Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
        image: image,
        fit: BoxFit.fill);

    if (value > 0.75) {
      Paint paint = Paint();
      paint.color =
          CustomMenu.color.withAlpha((((value - 0.75) * 4) * 255).toInt());
      canvas.drawRect(
          Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BPCACustomPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
