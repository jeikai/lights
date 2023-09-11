import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/util/image/ImageManager.dart';

class EggWidget extends StatefulWidget {
  const EggWidget({super.key});

  @override
  State<EggWidget> createState() => _EggWidgetState();
}

class _EggWidgetState extends State<EggWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _ani1;
  late Animation<double> _ani2;
  late Animation<double> _ani3;
  late Animation<double> _ani4;

  void _setupAnimation() {
    _ani1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 0.25, curve: Curves.linear)));
    _ani1.addListener(() {
      print("ani1: ${_ani1.value}");
    });
    _ani2 = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.25, 0.5, curve: Curves.linear)));
    _ani1.addListener(() {
      print("ani2: ${_ani2.value}");
    });
    _ani3 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 0.75, curve: Curves.linear)));
    _ani1.addListener(() {
      print("ani3: ${_ani3.value}");
    });
    _ani4 = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.75, 1, curve: Curves.linear)));
    _ani4.addListener(() {
      print("ani4: ${_ani4.value}");
    });
  }

  double _fv = 0;

  void _forwardAni() {
    if (_fv >= 1) return;
    _fv += 0.25;
    var a = _fv;
    _controller.animateTo(a);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300 * 4));
    _controller.addListener(() {
      print("controller: ${_controller.value}");
    });
    _setupAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: _calcChild(),
    );
  }

  (Animation<double>? ani, double state) getState() {
    switch (_fv) {
      case 0:
        print("is 0");
        return (null, 0);
      case 0.25:
        print("is 1");
        return (_ani1, 1);
      case 0.5:
        print("is 3");
        return (_ani2, 2);
      case 0.75:
        print("is 4");
        return (_ani3, 3);
      case 1:
        return (_ani4, 4);
      default:
        throw Exception("no such state at $_fv!!");
    }
  }

  bool _isNotAtTarget() {
    var v = _controller.value;
    return v != 1.0 || v != 2.0 || v != 3.0;
  }

  Widget _calcChild() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        (Animation<double>? ani, double state) state = getState();
        var v = state.$1?.value ?? 0;
        print("v: $v, is null: ${state.$1 == null}");
        double angle = sin(v * pi * 2) * pi / 6;

        return IgnorePointer(
          ignoring: !_isNotAtTarget(),
          child: Transform.rotate(
            angle: angle,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var v = _controller.value / 2;
                return ColorFiltered(
                  colorFilter: ColorFilter.matrix([
                    v * 2 + 1,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    v + 1,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    v * 2 + 1,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    1.0,
                    0.0,
                  ]),
                  child: Image.memory(
                    ImageManager().getBytes(ImageManager.egg)!,
                    fit: BoxFit.fitWidth,
                    width: constraints.maxWidth * 0.7,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onTap() {
    if (_fv < 1) {
      _forwardAni();
      return;
    } else {}
  }
//Navigator.pushNamed(context, '/GeneratedHelloscreenWidget')
}
