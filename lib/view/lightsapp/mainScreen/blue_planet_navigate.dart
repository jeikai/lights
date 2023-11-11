import 'package:flutter/material.dart';

import '../../../util/image/ImageManager.dart';

typedef CallBack = void Function(BuildContext context);

class BluePlanetNavigate extends StatefulWidget {
  final CallBack onClick;

  BluePlanetNavigate({Key? key, required this.onClick}) : super(key: key);

  @override
  _BluePlanetNavigateState createState() => _BluePlanetNavigateState();
}

class _BluePlanetNavigateState extends State<BluePlanetNavigate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick(context);
      },
      child: ClipOval(
        child: SizedBox(
          height: 300,
          width: 300,
          child: const _BluePlanetWrapper(),
        ),
      ),
    );
  }
}

class _BluePlanetWrapper extends StatelessWidget {
  const _BluePlanetWrapper();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 400),
      painter: _RPCustomPainter(),
    );
  }
}

class _RPCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
        canvas: canvas,
        rect: Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
        image: ImageManager().getUIImage(ImageManager.blue_planet)!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
