import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/icons/my_flutter_app_icons.dart';
import 'package:flutterapp/reusable_widget/vux/buttom/template.dart';
import 'package:flutterapp/reusable_widget/vux/listview/noti/notification_list_view.dart';

class NotificationMenu extends StatefulWidget {
  final VoidCallback removeOverlayCallback;

  static const Color colorMain = Color.fromARGB(255, 250,241,255);

  const NotificationMenu({Key? key, required this.removeOverlayCallback}) : super(key: key);

  @override
  _NotificationMenuState createState() => _NotificationMenuState();
}

class _NotificationMenuState extends State<NotificationMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool _finishAni = false;

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
        _finishAni = true;
      });
    });
    _controller.forward();
    //Todo: add Notification Process Listener
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void close() {
    _controller.reverse().then((value) => widget.removeOverlayCallback.call());
    setState(() {
      _finishAni = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_finishAni ? AnimatedBuilder(animation: _animation, builder: (context2, w) {
      return Transform.translate(
                  offset: _animation.value,
                  child: Material(
                    child: Container(
                        color: NotificationMenu.colorMain,
                        child: LayoutBuilder(
                          builder: (context2, cstr) {
                            double h = cstr.maxHeight;
                            double w = cstr.maxWidth;
                            double hTop = h * 0.1;
                            //double h_bot = h * 0.9;
                            return Column(
                              children: [
                                Container(
                                  key: Key("ThongBaoText"),
                                  height: hTop,
                                  width: w,
                                  child: Center(
                                    child: Text(
                                      "Thông báo",
                                      style: TextStyle(
                                          fontFamily: "Paytone One",
                                          fontSize: hTop * 0.33,
                                          decoration: null,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: h * 0.89,
                                  color: Colors.white,
                                )
                              ],
                            );
                          },
                        )),
                  ));
            })
        : NotificationMain(close);
  }
}

class NotificationMain extends StatelessWidget {

  final VoidCallback close;

  NotificationMain(this.close);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: NotificationMenu.colorMain,
          child: LayoutBuilder(
            builder: (context2, cstr) {
              double h = cstr.maxHeight;
              double w = cstr.maxWidth;

              double hTop = h * 0.1;
              //double h_bot = h * 0.9;
              return Column(
                children: [
                  Container(
                    height: hTop,
                    width: w,
                    child: Stack(
                      children: [
                        Container(
                          key: Key("ThongBaoText"),
                          height: hTop,
                          width: w,
                          child: Center(
                            child: Text(
                              "Thông báo",
                              style: TextStyle(
                                  fontFamily: "Paytone One",
                                  fontSize: hTop * 0.33,
                                  decoration: null,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0,
                          child: Container(
                            key: Key("CloseThongBaoButtom"),
                            width: hTop,
                            height: hTop,
                            child: Template(
                              innerColor: Color.fromARGB(255, 149, 147, 212),
                              icon: MyFlutterIcon.cancel,
                              bgColor: Colors.transparent,
                              width: hTop * 0.7,
                              height: hTop * 0.7,
                              padding: 0.0,
                              size: (hTop / 2),
                              onPress: () {
                                close.call();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: h * 0.89,
                    child: Padding(
                      padding: EdgeInsets.only(top: h / 20),
                      child: NotificationListView(),
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }

}


