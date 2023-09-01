import 'dart:math';

import 'package:flutter/material.dart';

class WhaleMenuBubbleBar extends StatefulWidget {
  final List<WhaleMenuBubble> children;

  const WhaleMenuBubbleBar({Key? key, required this.children})
      : super(key: key);

  @override
  _WhaleMenuBubbleBarState createState() => _WhaleMenuBubbleBarState();
}

class _WhaleMenuBubbleBarState extends State<WhaleMenuBubbleBar>
    with SingleTickerProviderStateMixin {
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
    double childSize = screenSize!.width * 1.2 / 3;
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

class WhaleMenuBubble extends StatefulWidget {
  final Widget child;
  final void Function(BuildContext context) onClick;

  const WhaleMenuBubble(
      {super.key, required this.child, this.onClick = _default});

  @override
  State<WhaleMenuBubble> createState() => _WhaleMenuBubbleState();
}

class _WhaleMenuBubbleState extends State<WhaleMenuBubble>
    with TickerProviderStateMixin {
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

    Future.delayed(Duration(milliseconds: Random().nextInt(100)))
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
        await Future.delayed(Duration(milliseconds: 500));
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
