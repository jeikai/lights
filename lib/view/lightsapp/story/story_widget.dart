import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  late final VideoPlayerController _controller;
  late final ValueNotifier<bool> skipped;

  Future<void> runTimer() async {
    await Future.delayed(Duration(seconds: 5));
    skipped.value = true;
  }

  @override
  void initState() {
    super.initState();
    skipped = ValueNotifier(false);
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('https://storage.googleapis.com/lightskn/story.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          runTimer();
        });
      });
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        _next();
      }
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    _controller.pause();
    Navigator.pushReplacementNamed(context, "/GeneratedHelloscreenWidget");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder<bool>(
                valueListenable: skipped,
                builder: (BuildContext context, bool value, Widget? child) {
                  return value
                      ? TextButton(
                          onPressed: () => _next(),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: t / 40,
                                fontFamily: "Paytone One",
                                fontWeight: FontWeight.w100),
                          ))
                      : SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
