import 'package:flutter/material.dart';

bool showCondition() {
  return true;
}

class TutorialHighlighterWidget extends StatefulWidget {
  final Widget child;
  final int positionX;
  final int positionY;
  final int width;
  final int height;
  final String tutorialKey;
  final String tutorialText;
  final bool Function() showCondition;

  TutorialHighlighterWidget({
    required this.child,
    required this.tutorialKey,
    required this.tutorialText,
    required this.showCondition,
    this.positionX = 0,
    this.positionY = 0,
    this.width = 100,
    this.height = 100,
  });

  @override
  _TutorialHighlighterWidgetState createState() =>
      _TutorialHighlighterWidgetState();
}

class _TutorialHighlighterWidgetState extends State<TutorialHighlighterWidget> {
  late final TutorialHighlighterController controller;

  @override
  void initState() {
    super.initState();
    controller = TutorialHighlighterController(context);
    if (widget.showCondition()) {
      Future.delayed(Duration(seconds: 3), () {
        controller.showTutorial(
          widget.tutorialKey,
          widget.tutorialText,
          positionX: widget.positionX,
          positionY: widget.positionY,
          width: widget.width,
          height: widget.height,
        );
      });
    }
  }

  @override
  void dispose() {
    controller.closeTutorial();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class TutorialHighlighterController {
  final BuildContext context;
  late final OverlayEntry overlayEntry;
  late final TutorialProvider tutorialProvider;

  TutorialHighlighterController(this.context) {
    tutorialProvider = TutorialProvider();
    overlayEntry = OverlayEntry(
      builder: (context) {
        return TutorialHighlighterOverlay(
          tutorialProvider: tutorialProvider,
          controller: this,
        );
      },
    );
  }

  void closeTutorial() {
    overlayEntry.remove();
  }

  void showTutorial(String tutorialKey, String tutorialText,
      {int positionX = 0,
        int positionY = 0,
        int width = 100,
        int height = 100}) {
    tutorialProvider.positionX = positionX;
    tutorialProvider.positionY = positionY;
    tutorialProvider.width = width;
    tutorialProvider.height = height;
    tutorialProvider.tutorialKey = tutorialKey;
    tutorialProvider.tutorialText = tutorialText;
    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry);
  }
}

class TutorialHighlighterOverlay extends StatefulWidget {
  final TutorialHighlighterController controller;
  final TutorialProvider tutorialProvider;

  TutorialHighlighterOverlay({
    required this.tutorialProvider,
    required this.controller,
  });

  @override
  _TutorialHighlighterOverlayState createState() =>
      _TutorialHighlighterOverlayState();
}

class _TutorialHighlighterOverlayState extends State<TutorialHighlighterOverlay>
    with SingleTickerProviderStateMixin {
  get controller => widget.controller;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
    Future.delayed(Duration(seconds: 5), () {
      _animationController.reverse().then((_) => controller.closeTutorial());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: widget.tutorialProvider.positionY.toDouble(),
          left: widget.tutorialProvider.positionX.toDouble(),
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              width: widget.tutorialProvider.width.toDouble(),
              height: widget.tutorialProvider.height.toDouble(),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(widget.tutorialProvider.tutorialText,
                  style: TextStyle(fontSize: 16)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TutorialProvider {
  String tutorialKey = "";
  String tutorialText = "";
  int positionX = 0;
  int positionY = 0;
  int width = 100;
  int height = 100;
}
