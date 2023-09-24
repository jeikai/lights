import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/avatar.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';

class AccountDetailWidget extends StatelessWidget {
  final String username;
  final ValueNotifier<bool> isConfig;

  const AccountDetailWidget(
      {super.key, required this.username, required this.isConfig});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ConfigMenuConverter(
      color: Color.fromRGBO(188, 220, 237, 1),
      oriHeight: size.height / 8,
      configHeight: 250,
      detailHeight: 400,
      isConfig: isConfig,
      configChild: AccountDetailConfigWidget(
        username: username,
      ),
      detailChild: AccountDetailDetailWidget(
        username: username,
      ),
      child: Row(
        key: Key("AccountDetailWidget"),
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all((size.height + size.width) / 2 * 0.02),
                child: Avatar(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Paytone One",
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(71, 79, 145, 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountDetailConfigWidget extends StatefulWidget {
  final String username;

  const AccountDetailConfigWidget({super.key, required this.username});

  @override
  State<AccountDetailConfigWidget> createState() =>
      _AccountDetailConfigWidgetState();
}

class _AccountDetailConfigWidgetState extends State<AccountDetailConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double avaSize = constraints.maxHeight * 0.5;
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: avaSize,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox.square(
                          dimension: avaSize,
                          child: Avatar(),
                        ),
                        Positioned(
                          right: 0,
                          child: editAvaButton(),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              widget.username,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Paytone One",
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: editNameButton(),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(71, 79, 145, 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 5.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget editAvaButton() {
    return EditButtonWidget(
      onClick: () {
        //TODO: change avatar
        //Write here

        //
        setState(() {});
      },
    );
  }

  Widget editNameButton() {
    return EditButtonWidget(
      onClick: () {
        //TODO: change avatar
        //Write here

        //
        setState(() {});
      },
    );
  }
}

class AccountDetailDetailWidget extends StatelessWidget {
  final String username;

  const AccountDetailDetailWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double avaSize = constraints.maxHeight * 0.6;
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: avaSize,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox.square(
                          dimension: avaSize,
                          child: Avatar(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              username,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Paytone One",
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(71, 79, 145, 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 5.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
