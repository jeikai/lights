import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Quote_text.dart';
import 'package:flutterapp/reusable_widget/Title_dark.dart';
import 'package:flutterapp/reusable_widget/background.dart';
import 'package:flutterapp/view/lightsapp/favoriteScreen/favorite_change_widget.dart';

import '../../../util/FavoriteDatas.dart';

class FavoriteScreenWidget extends StatefulWidget {
  FavoriteScreenWidget();

  @override
  State<FavoriteScreenWidget> createState() => _FavoriteScreenWidgetState();
}

class _FavoriteScreenWidgetState extends State<FavoriteScreenWidget> {
  late final ValueNotifier<int> cate;
  late final FavoriteData data;

  @override
  void initState() {
    super.initState();
    cate = ValueNotifier(0);
    data = FavoriteData();
  }

  @override
  void dispose() {
    cate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var width = size.width;
    return WillPopScope(
      child: Material(
          child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              //overflow: Overflow.visible,
              children: [
                BackGroundFavoriteScreen(),
                Positioned(
                  top: width * 5 / 100,
                  child: title("Hãy chọn điều\n bạn thích!!!"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FavoriteChangeWidget(
                    cate: cate,
                    data: data,
                  ),
                ),
                Positioned(
                  bottom: width * 20 / 100,
                  width: 326.0,
                  height: 71.0,
                  child: _Button(
                    cate: cate,
                    data: data,
                  ),
                ),
                Positioned(
                  bottom: width * 10 / 100,
                  width: 284.0,
                  height: 24.0,
                  child: quote("*các mục được chọn sẽ có màu vàng"),
                )
              ]),
        ),
      )),
      onWillPop: () async {
        return false;
      },
    );
  }
}

class _Button extends StatelessWidget {
  final ValueNotifier<int> cate;
  final FavoriteData data;

  const _Button({super.key, required this.cate, required this.data});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: cate,
        builder: (BuildContext context, int cate, Widget? child) {
          String text = isTLC(cate) ? "Hoàn tất" : "Tiếp theo";
          return TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(196, 160, 216, 1.0),
                foregroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                textStyle: TextStyle(
                  height: 1.396000067392985,
                  fontSize: 24.0,
                  fontFamily: 'Paytone One',
                  fontWeight: FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.white, width: 4.0),
                ),
              ),
              onPressed: isTLC(cate)
                  ? () => onPressedNavigate(context)
                  : onPressedNext,
              child: Text(text));
        });
  }

  void onPressedNavigate(context) {
    data.sendData();
    Navigator.pushNamed(context, '/GeneratedStartscreenWidget');
  }

  void onPressedNext() {
    print("click");
    cate.value = cate.value + 1;
    print("${cate.value}");
  }
}
