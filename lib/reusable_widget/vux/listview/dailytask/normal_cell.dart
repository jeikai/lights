import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:rive/rive.dart';

import '../../progress_bar.dart';

class NormalCell extends StatelessWidget {
  final AnimationController controller;
  final double percent;
  final String taskDes;
  final String? taskId;
  final double pbThickness;
  final double textSize;
  final Artboard artboard;

  late final Animation<double> lineAnimation;
  late final Star child;

  final ValueNotifier<double> valueNotifier = ValueNotifier(0.0);

  NormalCell({Key? key,
    required this.controller,
    required this.percent,
    required this.taskDes,
    this.pbThickness = 5,
    required this.textSize,
    this.taskId,
    required this.artboard})
      : super(key: key) {
    lineAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    child = Star(riveArtboard: artboard);
    lineAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed && percent == 1.0) {
        child.isFinished?.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double lW = constraints.maxWidth * 0.7;
          double rW = constraints.maxWidth * 0.3;
          return ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (BuildContext context, double value, Widget? widget) {
              return Row(
                children: [
                  SizedBox(
                    width: lW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Text(
                            taskDes,
                            style: TextStyle(
                              fontSize: textSize,
                              fontFamily: "Paytone One",
                            ),
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                          ),
                          width: lW * 0.8,
                        ),
                        AnimatedBuilder(
                            animation: lineAnimation,
                            builder: (context2, widget) {
                              return ProgressBar(
                                value: valueNotifier.value * lineAnimation.value,
                                height: pbThickness,
                                width: lW * 0.8,
                              );
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                      width: rW,
                      child: Padding(
                        padding: EdgeInsets.all(rW * 0.15),
                        child: GestureDetector(
                      onTap: () async {
                        if (percent == 1) return;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  onWillPop: () async => false);
                            });
                        await Future.delayed(Duration(milliseconds: 500));
                        if (taskId != null) {
                          if (!kReleaseMode) {
                            print("Update Mission State");
                          }
                          var temp = await Api()
                              .putDataById("updateMissionDayById", taskId!);
                          if (!kReleaseMode) {
                            print("Data: $temp");
                          }
                        }
                        Navigator.pop(context);
                        valueNotifier.value = 1.0;
                        child.isFinished?.value = true;
                      },
                          child: child,
                        ),
                      ))
                ],
              );
            },
          );
        });
  }
}

class Star extends StatefulWidget {
  final Artboard? riveArtboard;

  late final SMIInput<bool>? isFinished;

  Star({required this.riveArtboard});

  @override
  State<StatefulWidget> createState() => StarState();
}

class StarState extends State<Star> {
  @override
  void initState() {
    super.initState();
    var controller = StateMachineController.fromArtboard(
        widget.riveArtboard!, 'someanimation');
    if (controller != null) {
      widget.riveArtboard!.addController(controller);
      widget.isFinished = controller.findInput('isFinished');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Rive(
      fit: BoxFit.cover,
      artboard: widget.riveArtboard!,
    );
  }
}
