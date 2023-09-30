import 'package:flutter/material.dart';

class TemplateView extends StatelessWidget {
  final Color color;
  final double? height;
  final Widget child;

  const TemplateView({
    Key? key,
    required this.color,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        return Container(
          constraints: BoxConstraints.expand(height: height),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(size.width * 0.03)),
          ),
          child: child,
        );
      },
    );
  }
}
