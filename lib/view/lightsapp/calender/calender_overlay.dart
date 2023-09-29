import 'dart:math';

import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/calender/choose_emotion_widget.dart';
import 'package:flutterapp/view/lightsapp/calender/story_diary_widget.dart';

class MenuOverlay extends StatelessWidget {
  final DateTime time;
  final bool isToday;
  final bool isAfterDay;

  const MenuOverlay(
      {super.key,
      required this.time,
      this.isToday = false,
      this.isAfterDay = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: MenuBar(
                children: [
                  MenuBubble(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 244, 140, 167)
                                      .withOpacity(0.8),
                                  width: 10),
                              color: Color.fromARGB(255, 82, 167, 214)
                                  .withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.menu_book_rounded,
                              size: constraints.maxWidth * 0.8,
                              color: Color.fromARGB(255, 193, 230, 249),
                            ),
                          ),
                        );
                      },
                    ),
                    onClick: (BuildContext context) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StoryDiaryWidget(
                              time: time,
                            );
                          });
                    },
                  ),
                  if (isToday)
                    MenuBubble(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -constraints.maxWidth / 7,
                                top: -constraints.maxWidth / 7,
                                child: FluentUiEmojiIcon(
                                  fl: Fluents.flSmilingFace,
                                  w: constraints.maxWidth / 2.5 * 2,
                                  h: constraints.maxWidth / 2.5 * 2,
                                ),
                              ),
                              Positioned(
                                top: -constraints.maxWidth / 4,
                                right: -constraints.maxWidth / 5,
                                child: FluentUiEmojiIcon(
                                  fl: Fluents.flNauseatedFace,
                                  w: constraints.maxWidth / 2.5 * 2,
                                  h: constraints.maxWidth / 2.5 * 2,
                                ),
                              ),
                              Positioned(
                                right: -constraints.maxWidth / 7,
                                bottom: -constraints.maxWidth / 7,
                                child: FluentUiEmojiIcon(
                                  fl: Fluents.flWorriedFace,
                                  w: constraints.maxWidth / 2.5 * 2,
                                  h: constraints.maxWidth / 2.5 * 2,
                                ),
                              ),
                              Positioned(
                                bottom: -constraints.maxWidth / 4,
                                left: -constraints.maxWidth / 5,
                                child: FluentUiEmojiIcon(
                                  fl: Fluents.flPleadingFace,
                                  w: constraints.maxWidth / 2.5 * 2,
                                  h: constraints.maxWidth / 2.5 * 2,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      onClick: (BuildContext context) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ChooseEmotionWidget(
                                time: time,
                              );
                            });
                      },
                    )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuBar extends StatefulWidget {
  final List<MenuBubble> children;

  const MenuBar({Key? key, required this.children}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with SingleTickerProviderStateMixin {
  late final int size;
  late final Widget gd;
  late AnimationController _controller;

  static const double senMul = 0.9; //SensitivityMultiplier

  Size? screenSize;
  Offset? center;
  double? offsetY;

  void _initFundamentalDataIfNeeded() {
    if (screenSize == null && center == null) {
      var media = MediaQuery.of(context);
      assert(screenSize == null);
      screenSize = media.size;
      assert(center == null);
      center = screenSize!.center(Offset.zero);
      assert(offsetY == null);
      offsetY = screenSize!.height * 2.25 / 8;
    }
  }

  @override
  void initState() {
    size = widget.children.length;
    _controller = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: -0.5,
      upperBound: size.toDouble() - 1 + 0.5,
      duration: Duration(seconds: size),
      reverseDuration: Duration(seconds: size),
    );
    _controller.addListener(() {
      setState(() {});
    });

    gd = Positioned.fill(
      child: GestureDetector(
        child: Container(
          color: Color.fromARGB(20, 255, 255, 255),
        ),
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragEnd: _onHorizontalDragEnd,
      ),
    );

    super.initState();
    _controller.animateTo(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initFundamentalDataIfNeeded();
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      children: <Widget>[
        gd,
        ..._calcBubble(widget.children),
      ],
    );
  }

  //
  List<Widget> _calcBubble(List<Widget> children) {
    List<Widget> list = <Widget>[];
    int i = 0;
    double childSize = screenSize!.width * 1.4 / 3;
    double value = _controller.value;
    children.forEach((w) {
      var size = _calcSize(i.toDouble(), value, childSize);
      var pos =
          _calcPos(i.toDouble(), value, size, center!, screenSize!, offsetY!);
      var w2 = w;
      if (i != value)
        w2 = IgnorePointer(
          child: w,
        );
      var w3 = Positioned(
        child: SizedBox(
          width: size,
          height: size,
          child: w2,
        ),
        left: pos.dx,
        top: pos.dy,
      );
      list.add(w3);
      i++;
    });
    return list;
  }

  double _calcSize(double index, double value, covariant double childSize) {
    var newChildSize = childSize;
    var offset = value - index;
    if (offset.abs() < 1) {
      newChildSize = childSize - newChildSize * 1 / 4 * offset.abs();
    } else {
      newChildSize = childSize * 3 / 4;
    }

    return newChildSize;
  }

  Offset _calcPos(double index, double value, double size, Offset center,
      Size screenSize, double offsetY) {
    var offset = value - index;

    //calc dx:
    var dx = center.dx;
    //print("offset: $offset");
    dx += offset * screenSize.width / 2;
    //print("${center.dx}: $dx");

    //calc dy:
    var dy = center.dy;
    var oy = offsetY;
    if (offset.abs() < 1) {
      oy = offsetY - offsetY / 2 * offset.abs();
    } else {
      oy = offsetY / 2;
    }
    dy -= oy;

    //result
    Offset res = Offset(dx, dy);
    return res.translate(-size / 2, -size / 2);
  }

  Offset? _startPoint;

  // ignore: unused_field
  double? _dragStartValue;

  //
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    assert(_startPoint != null);

    // ignore: unused_local_variable
    var current = details.globalPosition;
    var delta = details.delta;
    var value = _controller.value;
    var dv = delta.dx * senMul / screenSize!.width; //formula of value's delta

    setState(() {
      _controller.value = (value + dv);
    }); //set value for updating the animation
    //print("$_startPoint: cp-$current: delta-$delta: v-$value");//for debug
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _controller.stop();
    _startPoint = details.globalPosition;
    _dragStartValue = _controller.value;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _startPoint = null;
    var target = _findTargetIndex(_controller.value);
    _controller.animateTo(target, duration: Duration(milliseconds: 200));
  }

  double _findTargetIndex(covariant double value) {
    double temp = value.toInt().toDouble();
    double dtemp = value - temp;
    return dtemp > 0.5 ? temp + 1 : temp;
  }
}

void _default(BuildContext context) {}

class MenuBubble extends StatefulWidget {
  final Widget child;
  final void Function(BuildContext context) onClick;

  const MenuBubble({super.key, required this.child, this.onClick = _default});

  @override
  State<MenuBubble> createState() => _MenuBubbleState();
}

class _MenuBubbleState extends State<MenuBubble> with TickerProviderStateMixin {
  late final AnimationController _ziggalController;
  late final AnimationController _clickController;

  late final Animation<double> _sizeAni;
  late final Animation<Offset> _ziggAni;

  bool isClicked = false;

  void _runZiggalAni() {
    try {
      _ziggalController.repeat(reverse: true);
    } catch (a) {}
  }

  @override
  void initState() {
    super.initState();

    _ziggalController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _ziggAni = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 10)).animate(
        CurvedAnimation(
            parent: _ziggalController, curve: Curves.easeInOutSine));

    Future.delayed(Duration(milliseconds: Random().nextInt(200) + 100))
        .then((value) => _runZiggalAni());

    _clickController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _clickController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    );

    _sizeAni = Tween<double>(begin: 1, end: 0.8).animate(curvedAnimation);
  }

  void onClick(BuildContext context) {
    if (isClicked) return;
    isClicked = true;
    _ziggalController.reset();
    _clickController.reset();
    _clickController.forward().then((value) {
      _clickController.reverse().then((value) async {
        widget.onClick(context);
        isClicked = false;
        _runZiggalAni();
      });
    });
  }

  @override
  void dispose() {
    _ziggalController.dispose();
    _clickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
          animation: Listenable.merge([_ziggAni, _sizeAni]),
          builder: (BuildContext context, Widget? child) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var w = constraints.maxWidth;
              var size = w * _sizeAni.value;
              //print(_sizeAni.value);
              return Center(
                child: Transform.translate(
                  offset: _ziggAni.value,
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: widget.child,
                  ),
                ),
              );
            });
          }),
      onTap: () {
        onClick(context);
      },
    );
  }
}
