import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/avatar.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/setting.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

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

  void onDragUpdate(DragUpdateDetails details) {
    double w = setting.widthSize;
    double dy = details.delta.dy;
    print("" + (dy / w).toString() + " " + dy.toString() + " " + w.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(this.context).size;
    double w = size.width;
    widget.inner.w = w;
    return GestureDetector(
      onHorizontalDragStart: _onPanStart,
      onHorizontalDragUpdate: _onPanUpdate,
      onHorizontalDragEnd: _onPanEnd,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          double dw = -(w / 20 + w / 5);
          return Center(
            child: Container(
              key: Key("NormalMainContainer"),
              width: w / 6 * 5.9,
              child: ClipRect(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: (w / 20 + w / 5 + w),
                  transform:
                      Matrix4.translationValues(dw * _animation.value.dx, 0, 0),
                  child: child!,
                ),
              ),
            ),
          );
        },
        child: Container(
          width: (w / 20 + w / 5 + w),
          child: Row(
            children: [
              Container(
                width: w / 5,
                child: Center(
                  child: Template(
                    icon: MyFlutterIcon.cancel,
                    width: w / 10,
                    height: w / 10,
                    innerColor: Colors.white,
                    bgColor: Colors.red,
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
    );
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

class InnerNormalCell extends StatelessWidget {
  InnerNormalCell(
      {Key? key, this.isClickable = false, this.onPress, required this.noti})
      : super(key: key);

  late double w;
  final bool isClickable;
  final VoidCallback? onPress;
  final NotificationContent noti;

  @override
  Widget build(BuildContext context) {
    double w = this.w * 0.9;
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
          Container(
            width: w_r,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: w_l / 10, bottom: w_l / 10),
                child: Text(
                  noti.content,
                  style: TextStyle(
                      fontFamily: "Paytone One",
                      decoration: null,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          Builder(builder: (context2) {
            return isClickable
                ? Container(
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
                : Container(
                    width: w_l,
                  );
          })
        ],
      ),
    );
  }
}
