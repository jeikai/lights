import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/vux/listview/dailytask/list_view.dart';

class DailyTaskProxy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context2, constraints) {
      return Dialog(
        insetAnimationCurve: Curves.easeOutBack,
        insetAnimationDuration: Duration(seconds: 1),
        surfaceTintColor: Colors.deepPurpleAccent,
        shadowColor: Color.fromARGB(0, 0, 0, 0),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        child: DailyTask(w: constraints.maxWidth, h: constraints.maxHeight / 6 * 4),
      );
    });
  }

}

class DailyTask extends StatefulWidget {
  final double h;
  final double w;

  DailyTask({Key? key, required this.h, required this.w}) : super(key: key);

  @override
  _DailyTaskState createState() => _DailyTaskState();
}

class _DailyTaskState extends State<DailyTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool finishAni = false;

  static const Color bg = Color.fromARGB(255, 250,241,255);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
    _animation = Tween<Offset>(
      begin: Offset(-1000.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) setState(() {
        finishAni = true;
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = widget.h;
    double w = widget.w;

    double radius = 16;

    return finishAni ? Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius)
      ),
      child: Column(
        children: [
          Container(
            height: h * 0.125,
            width: w,
            child: Center(
              child: Text("Nhiệm vụ hằng ngày",
                style: TextStyle(
                  fontFamily: "Paytone One",
                  fontSize: 25,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: h * 0.875,
            width: w,
            child: DTListView(borderRadius: radius,),
          )
        ],
      ),
    ) : AnimatedBuilder(animation: _animation, builder: (context2, widget) {
      return Transform.translate(
        offset: _animation.value,
        child: Center(
          child: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(radius)
            ),
            child: Column(
              children: [
                Container(
                  height: h * 0.125,
                  width: w,
                  child: Center(
                    child: Text("Nhiệm vụ hằng ngày",
                      style: TextStyle(
                        fontFamily: "Paytone One",
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: h * 0.875,
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                )
              ],
            ),
          )
        ),
      );
    });
  }
}
