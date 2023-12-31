import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/avatar.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/util/VuxUtil.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../model/notification.dart';
import '../../buttom/template.dart';

class NormalCell extends StatefulWidget {
  final InnerNormalCell inner;

  NormalCell(
      {Key? key,
      bool isClickable = false,
      VoidCallback? onPress,
      required NotificationContent noti})
      : inner = InnerNormalCell(
            noti: noti, isClickable: isClickable, onPress: onPress),
        super(key: key);

  @override
  State<NormalCell> createState() => _NormalCellState();
}

class _NormalCellState extends State<NormalCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  void _onPanStart(DragStartDetails details) {
    /*if(isForward == true) _controller.forward();
    else _controller.reverse();*/
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double dx = details.delta.dx; // Calculate the horizontal drag distance
    double v = _controller.value;
    _controller.value = v + dx / context.size!.width;
  }

  void _onPanEnd(DragEndDetails details) {
    if (_controller.value > 0.7) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(this.context).size;
    double w = size.width;
    widget.inner.w = (w);
    return VisibilityDetector(
        key: Key(widget.inner.noti.content),
        child: GestureDetector(
          onHorizontalDragStart: _onPanStart,
          onHorizontalDragUpdate: _onPanUpdate,
          onHorizontalDragEnd: _onPanEnd,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              double dw = -(w / 20 + w / 5);
              return Center(
                child: SizedBox(
                  key: Key("NormalMainContainer"),
                  width: w / 6 * 5.9,
                  height: widget.inner.height + 10,
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Positioned(
                        left: dw * _animation.value.dx,
                        child: SizedBox(
                          width: (w / 20 + w / 5 + w),
                          child: child!,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            child: SizedBox(
              width: (w / 20 + w / 5 + w),
              child: Row(
                children: [
                  SizedBox(
                    width: w / 5,
                    child: Center(
                      child: Template(
                        icon: MyFlutterIcon.cancel,
                        width: w / 10,
                        height: w / 10,
                        innerColor: Colors.white,
                        bgColor: Colors.red,
                        onPress: () {
                          NotificationManager()
                              .removeNotification(widget.inner.noti);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w / 20,
                  ),
                  widget.inner
                ],
              ),
            ),
          ),
        ),
        onVisibilityChanged: (VisibilityInfo infor) {
          if (infor.visibleFraction != 0) {
            NotificationManager().markNotificationAsRead(widget.inner.noti);
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
        .animate(_controller);
  }
}

// ignore: must_be_immutable
class InnerNormalCell extends StatelessWidget {
  InnerNormalCell(
      {Key? key, this.isClickable = false, this.onPress, required this.noti})
      : super(key: key);

  static final TextStyle style = TextStyle(
      fontFamily: "Paytone One", decoration: null, color: Colors.black);

  late double _w;
  late final double _height;
  final bool isClickable;
  final VoidCallback? onPress;
  final NotificationContent noti;

  double get height => (_height + _w * 0.9 / 3 * 3.9 / 10);

  set w(double width) {
    _w = width;
    _height = _calcHeight();
  }

  double _calcHeight() {
    return calcHeight(noti.content, style, _w * 0.9 / 6 * 3.9);
  }

  @override
  Widget build(BuildContext context) {
    double w = this._w * 0.9;
    double w_l = w / 6;
    double w_r = w / 6 * 3.9;
    return Container(
      constraints: BoxConstraints(minHeight: w_l),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 250, 241, 255),
        borderRadius: BorderRadius.circular(w_l / 4),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Container(
            width: w_l,
            height: w_l,
            child: Center(
              child: Avatar(
                size: w_l / 2,
              ),
            ),
          ),
          SizedBox(
            width: w_r,
            height: height,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: w_l / 10, bottom: w_l / 10),
                child: Text(
                  noti.content,
                  style: style,
                ),
              ),
            ),
          ),
          Builder(builder: (context2) {
            return isClickable
                ? SizedBox(
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
                  )
                : SizedBox(
                    width: w_l,
                  );
          })
        ],
      ),
    );
  }
}
