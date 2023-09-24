import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/template_view.dart';

class ConfigMenuConverter extends StatefulWidget {
  final double oriHeight;
  final double configHeight;
  final double? detailHeight;
  final ValueNotifier<bool> isConfig;
  final Widget child;
  final Widget configChild;
  final Widget? detailChild;
  final Color color;

  ConfigMenuConverter(
      {super.key,
      required this.configHeight,
      this.detailHeight,
      required this.oriHeight,
      required this.isConfig,
      required this.color,
      required this.child,
      required this.configChild,
      this.detailChild});

  @override
  State<ConfigMenuConverter> createState() => _ConfigMenuConverterState();
}

class _ConfigMenuConverterState extends State<ConfigMenuConverter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _clickController;

  late Animation<double> _animation1;
  late Animation<double> _animation2;

  bool isClick = false;

  @override
  void initState() {
    super.initState();
    widget.isConfig.addListener(onConfig);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _clickController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation1 = Tween(begin: widget.oriHeight, end: widget.configHeight)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn));
    _animation2 = Tween(
            begin: widget.oriHeight,
            end: widget.detailHeight ?? widget.oriHeight)
        .animate(CurvedAnimation(
            parent: _clickController,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn));
  }

  @override
  void dispose() {
    print("dispose");
    _controller.dispose();
    _clickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _clickController]),
      builder: (BuildContext context, Widget? child) {
        if (_controller.isAnimating || _controller.isCompleted) {
          return TemplateView(
            key: Key(widget.child.key.toString()),
            color: widget.color,
            height: getValueHeight(),
            child: getChild(),
          );
        }
        return GestureDetector(
          onTap: onTap,
          child: TemplateView(
            key: Key(widget.child.key.toString()),
            color: widget.color,
            height: getValueHeight(),
            child: getChild(),
          ),
        );
      },
    );
  }

  void onConfig() async {
    await _clickController.reverse();
    isClick = false;
    if (widget.isConfig.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void onTap() {
    print("tap");
    if (widget.detailChild == null) return;
    if (_controller.isAnimating || _controller.isCompleted) return;
    if (isClick) {
      _clickController.reverse();
    } else {
      _clickController.forward();
    }
    var b = isClick;
    isClick = !b;
  }

  double getValueHeight() {
    if (_controller.isAnimating || _controller.isCompleted)
      return _animation1.value;
    return _animation2.value;
  }

  Widget getChild() {
    if (_controller.isAnimating || _clickController.isAnimating)
      return SizedBox();
    if (_controller.isCompleted) return widget.configChild;
    if (_clickController.isCompleted) return widget.detailChild ?? widget.child;
    return widget.child;
  }
}

class AvaTitleWidget extends StatelessWidget {
  final double configHeight;
  final double oriHeight;
  final String title;
  final ValueNotifier<bool> isConfig;

  const AvaTitleWidget({
    super.key,
    required this.isConfig,
    required this.title,
    required this.configHeight,
    required this.oriHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConfigMenuConverter(
      configChild: SizedBox(),
      configHeight: configHeight,
      oriHeight: oriHeight,
      isConfig: isConfig,
      color: Colors.transparent,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: const Color.fromARGB(255, 137, 153, 205),
              fontFamily: "Paytone One",
              fontSize: 13),
        ),
      ),
    );
  }
}

class EditButtonWidget extends StatelessWidget {
  final void Function() onClick;

  const EditButtonWidget({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onClick,
        child: Text(
          "edit",
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Paytone One",
              decoration: TextDecoration.underline),
        ));
  }
}
