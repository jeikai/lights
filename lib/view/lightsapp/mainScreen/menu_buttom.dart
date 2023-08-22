import 'package:flutter/material.dart';

import '../../../reusable_widget/icons/my_flutter_app_icons.dart';
import '../../../reusable_widget/vux/buttom/template.dart';
import '../../../reusable_widget/vux/listview/dailytask/daily_task.dart';
import '../../../reusable_widget/vux/unread_indicator.dart';

typedef ShowOverlay = void Function(BuildContext context);

class MenuButtom extends StatelessWidget {
  final ShowOverlay showOverlay;

  const MenuButtom({Key? key, required this.showOverlay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Template(
          width: 50,
          height: 50,
          onPress: null,
          icon: MyFlutterIcon.home,
        ),
        SizedBox(width: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Template(
                width: 50,
                height: 50,
                onPress: () {
                  showOverlay(context);
                },
                icon: MyFlutterIcon.bell,
              ),
              Positioned(
                child: UnreadIndicator(
                  height: 20,
                  width: 20,
                ),
                top: -10,
                right: -10,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Template(
          width: 50,
          height: 50,
          onPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => DailyTaskProxy());
          },
          icon: MyFlutterIcon.list_alt,
        ),
      ],
    );
  }
}
