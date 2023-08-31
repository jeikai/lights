import 'package:flutter/material.dart';

class AnimatedWaitingPreloadMainScreen extends StatefulWidget {
  final Widget Function(BuildContext context) mainChildBuilder;
  final Widget Function(Widget child, Animation<double> animation)
      transitionBuilder;
  final Widget Function(Widget? currentCover, Widget mainScreenChild)
      layoutBuilder;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Duration duration;
  final Duration? reverseDuration;
  final Widget? cover;
  final Duration delay;

  const AnimatedWaitingPreloadMainScreen(
      {Key? key,
      required this.duration,
      this.reverseDuration,
      required this.mainChildBuilder,
      this.transitionBuilder =
          AnimatedWaitingPreloadMainScreen.defaultTransitionBuilder,
      this.layoutBuilder =
          AnimatedWaitingPreloadMainScreen.defaultLayoutBuilder,
      this.switchInCurve = Curves.linear,
      this.switchOutCurve = Curves.linear,
      this.cover,
      this.delay = Duration.zero})
      : super(key: key);

  @override
  _AnimatedWaitingPreloadMainScreenState createState() =>
      _AnimatedWaitingPreloadMainScreenState();

  static Widget defaultLayoutBuilder(
      Widget? currentCover, Widget mainScreenChild) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        mainScreenChild,
        if (currentCover != null) currentCover,
      ],
    );
  }

  static Widget defaultTransitionBuilder(
      Widget child, Animation<double> animation) {
    return FadeTransition(
      key: ValueKey<Key?>(child.key),
      opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
      child: child,
    );
  }
}

class _AnimatedWaitingPreloadMainScreenState
    extends State<AnimatedWaitingPreloadMainScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late final Widget _mainScreen;
  bool _isStart = false;
  // ignore: unused_field
  bool _isWaiting = true;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.switchInCurve,
        reverseCurve: widget.switchOutCurve));
    _buildMainScreenIfNeeded();
    _waiting();
    super.initState();
  }

  Future<void> _waiting() async {
    await Future.delayed(widget.delay);
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedWaitingPreloadMainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    if (!_isStart) {
      _isStart = true;
      _controller.forward();
    }
  }

  bool _isFinish() {
    return _controller.isCompleted;
  }

  void _buildMainScreenIfNeeded() {
    _mainScreen = widget.mainChildBuilder(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinish()) {
      return _mainScreen;
    } else {
      return widget.layoutBuilder(
          _AnimatedCoverWrapper(
            animation: _animation,
            transitionBuilder: widget.transitionBuilder,
            cover: widget.cover,
          ),
          _mainScreen);
    }
  }
}

class _AnimatedCoverWrapper extends StatefulWidget {
  final Animation<double> animation;
  final Widget Function(Widget child, Animation<double> animation)
      transitionBuilder;
  final Widget? cover;

  const _AnimatedCoverWrapper(
      {super.key,
      required this.animation,
      required this.transitionBuilder,
      this.cover});

  @override
  State<_AnimatedCoverWrapper> createState() => _AnimatedCoverWrapperState();
}

class _AnimatedCoverWrapperState extends State<_AnimatedCoverWrapper> {
  bool isFinish = false;

  @override
  Widget build(BuildContext context) {
    if (isFinish) return SizedBox();
    return AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          return widget.transitionBuilder(
              widget.cover ??
                  Container(
                    color: Colors.white,
                  ),
              widget.animation);
        });
  }

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() {
          isFinish = true;
        });
    });
  }
}
