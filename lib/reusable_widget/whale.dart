import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/util/ConfigManager.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:rive/rive.dart';

enum WhaleType {
  STATEMACHINE,
  ANI_ONE,
  ANI_TWO;
}

class Whale extends StatefulWidget {
  final bool isClickable;
  final WhaleType type;

  const Whale(
      {super.key,
      this.isClickable = false,
      this.type = WhaleType.STATEMACHINE});

  @override
  State<StatefulWidget> createState() => WhaleState();
}

class WhaleState extends State<Whale> with SingleTickerProviderStateMixin {
  RiveUtil? riveUtil;
  late Widget child;
  late SMIBool talking;
  late RiveFile whale;
  late Artboard ar;

  late AnimationController _controller;

  late String message = "";

  String oldmessage = "";

  double _width = 150;

  static const maxLine = 4;

  static const style = TextStyle(
      fontFamily: "Paytone One", decoration: null, color: Colors.black);

  String _getRandomMessage() {
    String res = "";
    Random random = Random(DateTime.now().microsecond);
    var config = ConfigManager();
    var list = config.whaleMessage;
    int i = random.nextInt(list.length);
    if (config.whaleMessage.length != 1 && list[i] == oldmessage) {
      i = random.nextInt(list.length);
    }
    res = list[i];
    oldmessage = res;
    return res;
  }

  bool _clicked = false;

  void _onClick() {
    if (_clicked) return;
    _clicked = true;
    final String _message = _getRandomMessage();
    setState(() {
      message = _message;
    });
  }

  void _initChild(WhaleType type) {
    try {
      whale = RiveUtil.WHALE;
      var artboard = whale.mainArtboard;
      ar = artboard;
      switch (type) {
        case WhaleType.STATEMACHINE:
          var controller = StateMachineController.fromArtboard(artboard, "Test",
              onStateChange: (String stateMachine, String animation) {
            switch (animation) {
              case "talking":
                if (widget.isClickable) _onClick();
            }
          });
          child = RiveAnimation.direct(
            whale,
            controllers: [controller!],
            onInit: (artboard) {
              talking = controller.findSMI('talking');
            },
          );
          break;
        case WhaleType.ANI_ONE:
          child = RiveAnimation.direct(
            whale,
            animations: ['talking'],
          );
          break;
        case WhaleType.ANI_TWO:
          child = RiveAnimation.direct(
            whale,
            animations: ['idle'],
          );
          break;
      }
    } catch (e) {
      child = SizedBox();
    }
  }

  void _removeMessage() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));

    await _controller.reverse().then((value) {
      _clicked = false;
      talking.value = false;
      setState(() {
        message = "";
      });
    });
  }

  Widget _buildChild(BuildContext context) {
    switch (widget.type) {
      case WhaleType.STATEMACHINE:
        return _buildOne(context);
      case WhaleType.ANI_TWO:
        return _buildTwoAndThree(context);
      case WhaleType.ANI_ONE:
        // TODO: Handle this case.
        return _buildTwoAndThree(context);
    }
  }

  Widget _buildOne(BuildContext context) {
    double bw = 150 > _width ? 150 : _width;
    double bh = 150;
    return ConstrainedBox(
      /*width: 273.0,
      height: 450.0,*/
      constraints: BoxConstraints(maxHeight: 450.0, maxWidth: 273.0),
      child: Stack(
        children: [
          child,
          Positioned(
            top: -(bh - 70),
            left: 0,
            child: message == ""
                ? SizedBox()
                : FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeIn,
                      ),
                    ),
                    child: WhaleBubble(
                      width: bw,
                      height: bh,
                      text: message,
                      remove: _removeMessage,
                    ),
                  ),
          )
        ],
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
      ),
    );
  }

  Widget _buildTwoAndThree(BuildContext context) {
    return ConstrainedBox(
      /*width: 273.0,
      height: 450.0,*/
      constraints: BoxConstraints(maxHeight: 450.0, maxWidth: 273.0),
      child: child,
    );
  }

  void _runAniIfNeeded() {
    if (message != "") _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _initChild(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    _runAniIfNeeded();
    return _buildChild(context);
  }
}

class WhaleBubble extends StatefulWidget {
  final double width;
  final double height;
  final String text;

  final VoidCallback remove;

  const WhaleBubble(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.remove})
      : super(key: key);

  @override
  State<WhaleBubble> createState() => _WhaleBubbleState();
}

class _WhaleBubbleState extends State<WhaleBubble> {
  // Your text to animate

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _fullText = widget.text;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            foregroundPainter: _BubblePainter(),
            size: Size(widget.width, widget.height),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: widget.width, maxHeight: widget.height - 30),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: TweenAnimationBuilder(
                  duration: Duration(
                      milliseconds:
                          150 * _fullText.length), // Adjust the duration
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (BuildContext context, double value, Widget? child) {
                    int charCount = (_fullText.length * value).toInt();
                    return Text(
                      _fullText.substring(0, charCount),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20), // Adjust font size
                    );
                  },
                  onEnd: widget.remove,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final double radius = 20;
  final double tail = 30;
  final double tailStart = 40;

  double get dt => tail / 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 250, 241, 255)
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius),
        radius: Radius.circular(radius));
    path.lineTo(size.width, size.height - tail - radius);
    path.arcToPoint(Offset(size.width - radius, size.height - tail),
        radius: Radius.circular(radius));
    path.lineTo(radius, size.height - tail);
    path.arcToPoint(Offset(0, size.height - tail - radius),
        radius: Radius.circular(radius));
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));

    Path path2 = Path();
    path.moveTo(tailStart, size.height - tail);
    path.arcToPoint(Offset(tailStart + dt, size.height - tail + dt),
        radius: Radius.circular(20));
    path.arcToPoint(Offset(tailStart + 3 * dt, size.height - tail + dt),
        radius: Radius.circular(dt / 2), clockwise: false);
    path.arcToPoint(Offset(tailStart + 4 * dt, size.height - tail),
        radius: Radius.circular(20));
    path.lineTo(tailStart, size.height - tail);

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
