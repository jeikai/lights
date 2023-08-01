import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../progress_bar.dart';

class NormalCell extends StatelessWidget {
  final AnimationController controller;
  final double percent;
  final String taskDes;
  final double pbThickness;
  final double textSize;
  final Artboard artboard;

  late final Animation<double> lineAnimation;
  late final Star child;

  NormalCell({Key? key, required this.controller, required this.percent, required this.taskDes, this.pbThickness = 5, required this.textSize, required this.artboard}) : super(key: key) {
    lineAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    child = Star(riveArtboard: artboard);
    lineAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed && percent == 1.0) {
        child.isFinished?.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double l_w = constraints.maxWidth * 0.7;
        double r_w = constraints.maxWidth * 0.3;
        return Row(
          children: [
            Container(
              width: l_w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(taskDes,
                      style: TextStyle(
                        fontSize: textSize,
                        fontFamily: "Paytone One",
                      ),
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
                    width: l_w * 0.8,
                  ),
                  AnimatedBuilder(animation: lineAnimation, builder: (context2, widget) {
                    return ProgressBar(
                      value: percent * lineAnimation.value,
                      height: pbThickness,
                      width: l_w * 0.8,
                    );
                  })
                ],
              ),
            ),
            Container(
              width: r_w,
              child: Padding(
                padding: EdgeInsets.all(r_w * 0.15),
                child: child,
              )
            )
          ],
        );
      }
    );
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
    var controller = StateMachineController.fromArtboard(widget.riveArtboard!, 'someanimation');
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