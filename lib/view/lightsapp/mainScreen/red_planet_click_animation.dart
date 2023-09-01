import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutterapp/util/image/ImageManager.dart';
import 'package:flutterapp/view/lightsapp/whaleMenu/whale_menu.dart';

class RedPlanetClickAnimation extends StatefulWidget {
  final context;
  final void Function() remove;
  final bool isReverse;

  const RedPlanetClickAnimation(this.context, this.remove, this.isReverse,
      {Key? key})
      : super(key: key);

  @override
  _RedPlanetClickAnimationState createState() =>
      _RedPlanetClickAnimationState();
}

class _RedPlanetClickAnimationState extends State<RedPlanetClickAnimation>
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
        print("pop");
      });
    } else {
      _controller.forward().then((value) {
        Navigator.pushNamed(widget.context, "/WhaleMenu");
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
          painter: _RPCACustomPainter(animation.value, image),
        );
      },
    );
  }
}

class _RPCACustomPainter extends CustomPainter {
  final double value;
  final ui.Image image;

  _RPCACustomPainter(this.value, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Path mPath = Path();
    Paint debugPaint = Paint();
    debugPaint.color = Colors.red;
    canvas.drawCircle(Offset(0, size.height), 10, debugPaint);
    mPath.moveTo(0, size.height);
    var h = size.height * value * 2;
    mPath.lineTo(0, size.height - h);
    mPath.arcToPoint(Offset(h, size.height), radius: Radius.circular(h));
    mPath.lineTo(0, size.height);

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
          WhaleMenu.color.withAlpha((((value - 0.75) * 4) * 255).toInt());
      canvas.drawRect(
          Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RPCACustomPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
