import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/custommenu/custom_menu_listview.dart';
import 'package:rive/rive.dart';
import '../../../reusable_widget/animated_switcher_with_preload_main_screen.dart';
import '../../../util/rive/RiveUtil.dart';
import '../mainScreen/MainScreen.dart';

class CustomMenu extends StatelessWidget {
  static GlobalKey<AnimatedWaitingPreloadMainScreenState> aniKey = GlobalKey();

  final RiveFile bg = RiveUtil.BGONE;

  static const Color color = Color.fromARGB(255, 104, 164, 236);

  CustomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gap = size.width * 0.075;
    double padding = size.width * 0.1;
    double iconSize = size.width * 0.07; // Kích thước của biểu tượng

    return WillPopScope(
      child: Material(
        child: AnimatedWaitingPreloadMainScreen(
          duration: Duration(milliseconds: 500),
          mainChildBuilder: (context) {
            return Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              children: [
                RiveAnimation.direct(
                  bg,
                  artboard: 'bg2',
                  fit: BoxFit.fitHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: padding, right: padding, top: gap, bottom: gap),
                  child: CustomMenuListview(
                    children: [
                      CustomMenuListViewCell(
                        color: Color.fromARGB(255, 225, 200, 239),
                        text: "MỤC NHẠC",
                        icon: SizedBox(),
                        onPress: () {
                          Navigator.pushNamed(context, '/Music');
                        }, // Add the path parameter
                      ),
                      CustomMenuListViewCell(
                        color: Color.fromARGB(255, 172, 193, 254),
                        text: "MỤC PHIM",
                        icon: SizedBox(),
                        onPress: () {
                          Navigator.pushNamed(context, '/Movie');
                        }, // Add the path parameter
                      ),
                    ],
                    gap: gap,
                  ),
                ),
                Positioned(
                  top: size.height * 0.02, // Vị trí dựa trên kích thước màn hình
                  left: size.width * 0.02, // Vị trí dựa trên kích thước màn hình
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: iconSize,
                    ),
                  ),
                ), // Thêm InkWell cho nút "Quay lại"
              ],
            );
          },
          cover: Container(
            color: color,
          ),
          delay: Duration(milliseconds: 100),
          key: aniKey,
        ),
      ),
      onWillPop: () async {
        await aniKey.currentState!.startOuttro();
        var state = MainScreenWidget.aniKey2.currentState!;
        state.widget.bluePlanetClick(state.context, true);
        return true;
      },
    );
  }
}
