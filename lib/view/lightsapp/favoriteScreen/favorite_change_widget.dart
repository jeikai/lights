import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/favoriteScreen/favorite_list.dart';

import '../../../util/FavoriteDatas.dart';

class FavoriteChangeWidget extends StatefulWidget {
  final FavoriteData data;
  final ValueNotifier<int> cate;

  const FavoriteChangeWidget({Key? key, required this.data, required this.cate})
      : super(key: key);

  @override
  _FavoriteChangeWidgetState createState() => _FavoriteChangeWidgetState();
}

class _FavoriteChangeWidgetState extends State<FavoriteChangeWidget>
    with SingleTickerProviderStateMixin {
  late Widget child;

  @override
  void initState() {
    super.initState();
    child = FavoriteList(
      data: widget.data,
      category: 0,
    );
    widget.cate.addListener(() {
      setState(() {
        child = FavoriteList(
          key: Key("new${widget.cate.value}"),
          data: widget.data,
          category: widget.cate.value,
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
