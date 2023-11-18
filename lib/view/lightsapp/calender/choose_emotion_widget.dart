import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/CalenderController.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/calender/calender_screen.dart';

class ChooseEmotionWidget extends StatefulWidget {
  final DateTime time;

  const ChooseEmotionWidget({Key? key, required this.time}) : super(key: key);

  @override
  _ChooseEmotionWidgetState createState() => _ChooseEmotionWidgetState();
}

class _ChooseEmotionWidgetState extends State<ChooseEmotionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _animation2;

  String get _time => Preferences.formatDate(widget.time);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween(begin: -2 * pi, end: -pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _animation2 = Tween<double>(begin: 0, end: 60.0).animate(CurvedAnimation(
        parent: CurvedAnimation(parent: _controller, curve: Interval(0.5, 1)),
        curve: Curves.easeInOut));
  }

  bool isPlayed = false;

  void forward() {
    if (isPlayed) return;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    forward();
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.fromSize(
            size: size,
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return CircleList(
                    origin: Offset.zero,
                    initialAngle: _animation.value,
                    rotateMode: RotateMode.stopRotate,
                    innerRadius: _animation2.value,
                    children: [
                      _EmotionButton(
                          onPress: () {
                            if (!kReleaseMode) {
                              print("Cực buồn");
                            }
                            _updateEmotions(_time, "CucBuon").then((value) {
                              if (!kReleaseMode) {
                                print("update completed");
                              }
                              var v = CalenderScreen.calenderNotifier.value;
                              CalenderScreen.calenderNotifier.value = !v;
                            });
                          },
                          child: FluentUiEmojiIcon(
                              fl: Fluents.flLoudlyCryingFace, w: t, h: t)),
                      _EmotionButton(
                          onPress: () {
                            if (!kReleaseMode) {
                              print("Buồn");
                            }
                            _updateEmotions(_time, "Buon").then((value) {
                              if (!kReleaseMode) {
                                print("update completed");
                              }
                              var v = CalenderScreen.calenderNotifier.value;
                              CalenderScreen.calenderNotifier.value = !v;
                            });
                          },
                          child: FluentUiEmojiIcon(
                              fl: Fluents.flFrowningFace, w: t, h: t)),
                      _EmotionButton(
                          onPress: () {
                            if (!kReleaseMode) {
                              print("Bình thường");
                            }
                            _updateEmotions(_time, "BinhThuong").then((value) {
                              if (!kReleaseMode) {
                                print("update completed");
                              }
                              var v = CalenderScreen.calenderNotifier.value;
                              CalenderScreen.calenderNotifier.value = !v;
                            });
                          },
                          child: FluentUiEmojiIcon(
                              fl: Fluents.flNeutralFace, w: t, h: t)),
                      _EmotionButton(
                          onPress: () {
                            if (!kReleaseMode) {
                              print("Vui");
                            }
                            _updateEmotions(_time, "Vui").then((value) {
                              if (!kReleaseMode) {
                                print("update completed");
                              }
                              var v = CalenderScreen.calenderNotifier.value;
                              CalenderScreen.calenderNotifier.value = !v;
                            });
                          },
                          child: FluentUiEmojiIcon(
                              fl: Fluents.flGrinningFaceWithSmilingEyes,
                              w: t,
                              h: t)),
                      _EmotionButton(
                          onPress: () {
                            if (!kReleaseMode) {
                              print("Cực vui");
                            }
                            _updateEmotions(_time, "CucVui").then((value) {
                              if (!kReleaseMode) {
                                print("update completed");
                              }
                              var v = CalenderScreen.calenderNotifier.value;
                              CalenderScreen.calenderNotifier.value = !v;
                            });
                          },
                          child: FluentUiEmojiIcon(
                              fl: Fluents.flGrinningSquintingFace, w: t, h: t)),
                    ],
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _updateEmotions(String date, String emotion) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    await CalenderController.updateEmotions(date, emotion);
    Navigator.pop(context);
    Navigator.pop(context);
    return;
  }
}

class _EmotionButton extends StatelessWidget {
  final void Function() onPress;
  final Widget child;

  const _EmotionButton({required this.onPress, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: t / 6,
        height: t / 6,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
        child: child,
      ),
    );
  }
}
