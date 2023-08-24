import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

class RedPlanetNavigate extends StatefulWidget {
  const RedPlanetNavigate({Key? key}) : super(key: key);

  @override
  _RedPlanetNavigateState createState() => _RedPlanetNavigateState();
}

class _RedPlanetNavigateState extends State<RedPlanetNavigate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late RiveFile planet;
  Widget child = Container();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();

    planet = RiveUtil().BGONE;
    child = RiveAnimation.direct(
      planet,
      artboard: "red_star",
      fit: BoxFit.fill,
    );
  }

  void onClick() {
    print("clicked");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: ClipOval(
        child: Container(
          height: 400,
          width: 400,
          child: child,
        ),
      ),
    );
  }
}
