import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

typedef CallBack = void Function(BuildContext context);

class RedPlanetNavigate extends StatefulWidget {
  final CallBack onClick;

  RedPlanetNavigate({Key? key, required this.onClick}) : super(key: key);

  @override
  _RedPlanetNavigateState createState() => _RedPlanetNavigateState();
}

class _RedPlanetNavigateState extends State<RedPlanetNavigate> {
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
          height: 400,
          width: 400,
          child: const _RedPlanetWrapper(),
        ),
      ),
    );
  }
}

class _RedPlanetWrapper extends StatelessWidget {
  const _RedPlanetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.direct(
      RiveUtil.BG,
      artboard: "red_star",
      fit: BoxFit.fill,
    );
  }
}
