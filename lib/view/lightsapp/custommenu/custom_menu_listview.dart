import 'package:flutter/material.dart';

class CustomMenuListview extends StatefulWidget {
  final List<CustomMenuListViewCell> children;
  final double gap;

  CustomMenuListview({Key? key, required this.children, required this.gap})
      : super(key: key);

  @override
  _CustomMenuListviewState createState() => _CustomMenuListviewState();
}

class _CustomMenuListviewState extends State<CustomMenuListview> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return widget.children[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: widget.gap,
        );
      },
      itemCount: widget.children.length,
      clipBehavior: Clip.none,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
    );
  }
}

void _default(context) {
  print("a");
}

class CustomMenuListViewCell extends StatelessWidget {
  final Color color;
  final String text;
  final Widget icon;
  final void Function(BuildContext context) onClick;

  const CustomMenuListViewCell(
      {super.key,
      required this.color,
      required this.text,
      required this.icon,
      this.onClick = _default});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size size = MediaQuery.of(context).size;
      final extent = size.height / 4.5;
      return Container(
        constraints: BoxConstraints.expand(height: extent),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(size.width * 0.03)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 2 / 5,
                    child: Padding(
                      child: Center(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Paytone One",
                            fontSize: constraints.maxWidth * 0.05,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                  Expanded(
                    child: icon,
                  )
                ],
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: extent * 2 / 5,
              child: Center(
                child: _CMLVCNButton(
                  onClick: onClick,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class _CMLVCNButton extends StatefulWidget {
  final void Function(BuildContext context) onClick;

  const _CMLVCNButton({required this.onClick});

  @override
  State<_CMLVCNButton> createState() => _CMLVCNButtonState();
}

class _CMLVCNButtonState extends State<_CMLVCNButton>
    with SingleTickerProviderStateMixin {
  static Color color = Color.fromARGB(255, 250, 241, 255);

  late final Widget child;
  late final AnimationController _clickController;

  late final Animation<double> _sizeAni;

  bool isClicked = false;

  void onClick(BuildContext context) {
    if (isClicked) return;
    isClicked = true;
    _clickController.reset();
    _clickController.forward().then((value) {
      _clickController.reverse().then((value) async {
        isClicked = false;
        Navigator.pushNamed(context, '/Movie');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _clickController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _clickController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    );

    _sizeAni = Tween<double>(begin: 1, end: 0.8).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
          animation: _sizeAni,
          builder: (context, child) {
            return Transform.scale(
              scale: _sizeAni.value,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  width: constraints.maxWidth * 5 / 7,
                  height: constraints.maxHeight / 2,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(100, 50))),
                  child: Center(
                    child: Text(
                      "CHẠM VÀO",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Paytone One",
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
      onTap: () {
        onClick(context);
      },
    );
  }
}
