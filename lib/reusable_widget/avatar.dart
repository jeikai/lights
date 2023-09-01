import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double? size;
  final String? avatar;
  const Avatar({Key? key, this.size, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context2, constr) {
      double c = size ??
          (constr.maxWidth > constr.maxHeight
              ? constr.maxHeight
              : constr.maxWidth);
      double r = c / 2;
      return Container(
        height: c,
        width: c,
        child: CircleAvatar(
          radius: r,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: r * 0.95,
            backgroundColor: Color.fromARGB(255, 228, 225, 243),
            child: CircleAvatar(
              radius: r * 0.75,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                  radius: r * 0.7,
                  backgroundColor: avatar == null
                      ? Color.fromARGB(255, 135, 161, 201)
                      : null,
                  backgroundImage:
                      avatar == null ? null : NetworkImage(avatar!)),
            ),
          ),
        ),
      );
    });
  }
}
