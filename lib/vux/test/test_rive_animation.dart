import 'dart:js_interop';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class TestRiveWidget extends StatefulWidget {
  const TestRiveWidget({super.key});

  @override
  State<StatefulWidget> createState() => TestRiveState();
}

class TestRiveState extends State<TestRiveWidget> {
  bool get isPlaying => _controller?.isActive ?? false;

  double? _startSize;
  StateMachineController? _controller;
  SMINumber? rating;
  RiveFile? file;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    await rootBundle.load('asset/rating.riv').then((value)
    {
      RiveFile file = RiveFile.import(value);
      setState(() {
        this.file = file;
      });
    });
  }

  void _handleCancelRating() {
    rating?.value = 0;
  }

  void _onInit(Artboard artboard) {
    _controller = StateMachineController.fromArtboard(artboard, "test_123");
    artboard.addController(_controller!);
    rating = _controller!.findInput<double>("rating") as SMINumber;
  }

  @override
  Widget build(BuildContext context) {
    if(file == null) return Container();
    return Container(
      height: 400,
      width: 400,
      child: GestureDetector(
        onDoubleTapDown: (details) {
          _handleCancelRating();
        },
        child: RiveAnimation.direct(
          file!,
          onInit: _onInit,
        )
      ),
    )
    ;
  }
}