import 'package:flutter/material.dart';

class TemplateView extends StatelessWidget {
  final Color color;
  final double height;
  final List<Widget> children;

  const TemplateView({
    Key? key,
    required this.color,
    required this.height,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        return Container(
          margin: EdgeInsets.only(
            top: 0,
            bottom: 10,
          ),
          constraints: BoxConstraints.expand(height: height),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(size.width * 0.03)),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: children,
          ),
        );
      },
    );
  }
}
