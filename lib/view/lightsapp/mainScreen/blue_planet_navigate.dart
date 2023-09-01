import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

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
  const _BluePlanetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.direct(
      RiveUtil.BG,
      artboard: "red_star",
      fit: BoxFit.fill,
    );
  }
}
