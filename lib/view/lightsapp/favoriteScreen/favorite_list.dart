import 'package:flutter/material.dart';
import 'package:flutterapp/util/FavoriteDatas.dart';

class FavoriteList extends StatefulWidget {
  final int? iniSize;
  final FavoriteData data;
  late final int _category;

  FavoriteList(
      {Key? key, this.iniSize, required int category, required this.data})
      : _category = category,
        super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late ValueNotifier<bool> _reverse;

  final List<Widget> currentWidget = <Widget>[];
  int oldValue = 0;

  late final int size;
  late final int row;

  bool isComplete = false;

  @override
  void initState() {
    size = widget.iniSize ?? getCategorySize(widget._category);
    row = size ~/ 3 + 1;
    _reverse = ValueNotifier(false);
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 250 * size));
    _animation = IntTween(begin: 0, end: size).animate(_controller);
    _animation.addListener(() {
      var v = _animation.value;
      if (v == oldValue) return;
      oldValue = v;
      print(v);
      setState(() {
        final a = _FavoriteCell(
          wrapper: widget.data
              .getWrapper(getGlobalIndex(widget._category, oldValue - 1)),
          child: getWidgetOfCategory(widget._category, oldValue - 1),
          reverse: _reverse,
        );
        currentWidget.add(
          a,
        );
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() {
          isComplete = true;
        });
    });
    super.initState();
    _runAnimation();
  }

  @override
  void dispose() {
    _reverse.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool isRun = false;

  void _runAnimation() {
    if (isRun) return;
    _controller.forward();
    isRun = true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var a = _buildChild(context, constraints);
      return IgnorePointer(
        ignoring: !isComplete,
        child: a,
      );
    });
  }

  Widget _buildChild(BuildContext context, BoxConstraints constraints) {
    double w = constraints.maxWidth / (3.2);
    double gap = w * 0.1;
    return _buildList(w, gap);
  }

  Widget _buildList(double w, double gap) {
    List<Widget> columWidgets = <Widget>[];
    for (int y = 0; y < row; y++) {
      List<Widget> rowWidgets = <Widget>[];
      int rowLenght = (y == row - 1) ? size % 3 : 3;
      for (int i = 0; i < rowLenght; i++) {
        Widget? inner = currentWidget.elementAtOrNull(y * 3 + i);
        rowWidgets.add(
          SizedBox(
            width: w,
            height: w,
            child: inner,
          ),
        );
        if (i == rowLenght - 1) break;
        rowWidgets.add(SizedBox(
          width: gap,
        ));
      }
      columWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: rowWidgets,
      ));
      if (y == row - 1) break;
      columWidgets.add(SizedBox(
        width: gap,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: columWidgets,
    );
  }
}

class _FavoriteCell extends StatefulWidget {
  final Widget? child;
  final ValueNotifier<bool> reverse;
  final FavoriteWrapper wrapper;

  const _FavoriteCell(
      {this.child, required this.reverse, required this.wrapper});

  @override
  State<_FavoriteCell> createState() => _FavoriteCellState();
}

class _FavoriteCellState extends State<_FavoriteCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacAnimation;
  late Animation<Offset> _posAnimation;
  late ValueNotifier<bool> _isClick;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _posAnimation = Tween<Offset>(begin: Offset(0, 100), end: Offset(0, 0))
        .animate(_opacAnimation);
    _runAnimation();
    _isClick = ValueNotifier(widget.wrapper.isChose);
    super.initState();
  }

  @override
  void dispose() {
    _isClick.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool isRun = false;

  void _runAnimation() {
    if (isRun) return;
    isRun = true;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _isClick]),
      builder: (context, widget) {
        return Transform.translate(
          offset: _posAnimation.value,
          child: Opacity(
            opacity: _opacAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.yellow.withOpacity(_isClick.value ? 1 : 0),
                    width: 10),
                borderRadius: BorderRadius.circular(10000),
              ),
              child: widget,
            ),
          ),
        );
      },
      child: GestureDetector(
        child: widget.child ?? const SizedBox(),
        onTap: onTap,
      ),
    );
  }

  void onTap() {
    _isClick.value = !_isClick.value;
    widget.wrapper.isChose = _isClick.value;
  }
}
