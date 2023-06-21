import 'package:flutter/material.dart';

class TestAnimation extends StatefulWidget {
  const TestAnimation({Key? key}) : super(key: key);

  @override
  State createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10) // Provide the duration for the animation
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAni() {
    if(_controller.isCompleted) _controller.reset();
    _controller.forward();
  }
  
  void stopAni() {
    _controller.stop();
  }

  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Text((_controller.value * 10).round().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FloatingActionButton(onPressed: startAni),
        AnimatedBuilder(
          animation: _controller,
          builder: animatedBuilder,
        ),
        FloatingActionButton(onPressed: stopAni)
      ],
    );
  }

}
