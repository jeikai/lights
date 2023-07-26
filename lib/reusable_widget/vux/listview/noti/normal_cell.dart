import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/avatar.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

import '../../../../model/notification.dart';

class NormalCell extends StatelessWidget {
  const NormalCell({Key? key, this.isClickable = false, this.onPress, required this.noti}) : super(key: key);

  final bool isClickable;
  final VoidCallback? onPress;
  final NotificationContent noti;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context2, constr) {
      double w_l = constr.maxWidth / 6;
      double w_r = constr.maxWidth / 6 * 3.9;
      return Container(
        height: w_l,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 250,241,255),
          borderRadius: BorderRadius.circular(w_l / 4),
          border: Border.all(),
        ),
        child: Row(
          children: [
            Container(
              width: w_l,
              child: Center(
                child: Avatar(
                  size: w_l / 2,
                ),
              ),
            ),
            Container(
              width: w_r,
              child: Center(

              ),
            ),
            Builder(builder: (context2) {
              return isClickable ? Container(
                width: w_l,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      onPress?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: RiveAnimation.direct(RiveUtil().getStar()),
                  ),
                ),
              ) : Container();
            })
          ],
        ),
      );
    });
  }
}
