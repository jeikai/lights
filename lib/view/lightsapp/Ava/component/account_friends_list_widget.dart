import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';

class AccountFriendsListWidget extends StatelessWidget {
  final ValueNotifier<bool> isConfig;

  const AccountFriendsListWidget({Key? key, required this.isConfig})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ConfigMenuConverter(
      color: Color.fromARGB(255, 118, 136, 208),
      oriHeight: size.height * 0.1875,
      configHeight: size.height,
      isConfig: isConfig,
      configChild: SizedBox(),
      child: SizedBox(
        key: Key("AccountFriendsListWidget"),
      ),
    );
  }
}
