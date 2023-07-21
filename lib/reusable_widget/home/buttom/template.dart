import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  final AssetImage icon;

  const Template({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class TemplateButtom extends StatefulWidget {
  const TemplateButtom({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class TemplateButtomState extends State<TemplateButtom> {

  final AssetImage icon;
  final void Function(TapUpDetails details) onClick;

  TemplateButtomState({required this.icon, required this.onClick});

  late Image iconWidget;

  @override
  void initState() {
    super.initState();
    iconWidget = Image(image: icon);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onClick,
      onTapDown: onHover,
      child: Stack(

      ),
    );
  }

  void onHover(TapDownDetails details) {

  }

}


