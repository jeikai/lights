import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/URLAnalyzer.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/config_menu_converter.dart';

class AccountDescriptionWidget extends StatelessWidget {
  final double padding;
  final ValueNotifier<bool> isConfig;

  const AccountDescriptionWidget(
      {super.key, required this.padding, required this.isConfig});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ConfigMenuConverter(
      color: Color.fromRGBO(168, 195, 230, 1),
      oriHeight: size.height / 7.2,
      configHeight: 600,
      configChild: AccountDescriptionConfigWidget(),
      detailChild: AccountDescriptionDetailWidget(),
      detailHeight: 450,
      isConfig: isConfig,
      child: Padding(
        key: Key("AccountDescriptionWidget"),
        padding: EdgeInsets.symmetric(
            horizontal: padding * 0.3, vertical: padding * 0.4),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            Preferences.bio!,
            style: TextStyle(fontSize: 16.0, fontFamily: "Paytone One"),
          ),
        ),
      ),
    );
  }
}

class AccountDescriptionConfigWidget extends StatefulWidget {
  const AccountDescriptionConfigWidget({super.key});

  @override
  State<AccountDescriptionConfigWidget> createState() =>
      _AccountDescriptionConfigWidgetState();
}

class _AccountDescriptionConfigWidgetState
    extends State<AccountDescriptionConfigWidget> {
  void editBioButton() async {
    //TODO: change bio
    //Write here
    TextEditingController textController = TextEditingController();
    textController.text = Preferences.bio!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bio'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter text'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the text input, e.g., send it to an API
                String inputText = textController.text;
                print('You entered: $inputText');
                Preferences.setBioUpdate(inputText);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    //
    setState(() {});
  }

  void editDOBButton() async {
    //TODO: change dob
    //Write here
    TextEditingController textController = TextEditingController();
    textController.text = Preferences.getDOB()!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Date of Birth'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter text'),
            maxLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the text input, e.g., send it to an API
                String inputText = textController.text;
                print('You entered: $inputText');
                Preferences.setDOBUpdate(inputText);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    //
    setState(() {});
  }

  void editMailButton() async {
    //TODO: change mail
    //Write here
    TextEditingController textController = TextEditingController();
    textController.text = Preferences.getEmail()!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mail'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter text'),
            maxLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the text input, e.g., send it to an API
                String inputText = textController.text;
                print('You entered: $inputText');
                Preferences.setMailUpdate(inputText);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    //
    setState(() {});
  }

  void editPhoneButton() async {
    //TODO: change phone
    //Write here
    TextEditingController textController = TextEditingController();
    textController.text = Preferences.getPhoneNumber()!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Phone'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter text'),
            maxLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the text input, e.g., send it to an API
                String inputText = textController.text;
                print('You entered: $inputText');
                Preferences.setPhoneUpdate(inputText);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    //
    setState(() {});
  }

  void editAddressButton() async {
    //TODO: change address
    //Write here
    TextEditingController textController = TextEditingController();
    textController.text = Preferences.getAddress()!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Address'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Enter text'),
            maxLines: 1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the text input, e.g., send it to an API
                String inputText = textController.text;
                print('You entered: $inputText');
                Preferences.setAddressUpdate(inputText);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    //
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(150),
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.03)),
        border: Border.all(
          width: 2,
          color: Color.fromARGB(200, 118, 136, 208),
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                //Bio
                height: 71,
                width: constraints.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth / 5 * 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 4),
                        child: SingleChildScrollView(
                          child: Text(
                            Preferences.bio!,
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Paytone One"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Center(
                        child: EditButtonWidget(onClick: editBioButton),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey, // You can change the color of the line
                thickness: 1, // Adjust the thickness of the line
              ),
              SizedBox(
                height: 118.3,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight / 4,
                            child: contactEditWidget(size, Icons.date_range,
                                Preferences.getDOB()!, editDOBButton),
                          ),
                          SizedBox(
                            height: constraints.maxHeight / 4,
                            child: contactEditWidget(size, Icons.mail,
                                Preferences.getEmail()!, editMailButton),
                          ),
                          SizedBox(
                            height: constraints.maxHeight / 4,
                            child: contactEditWidget(size, Icons.phone,
                                Preferences.getPhoneNumber()!, editPhoneButton),
                          ),
                          SizedBox(
                            height: constraints.maxHeight / 4,
                            child: contactEditWidget(size, Icons.home,
                                Preferences.getAddress()!, editAddressButton),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey, // You can change the color of the line
                thickness: 1, // Adjust the thickness of the line
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var p = Preferences.socialConnections;
                    if (p.isEmpty) return null;
                    String url = p[index];
                    (IconData, String) temp = URLAnalyzer().analyze(url);
                    return contactWidget(size, temp.$1, temp.$2);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget contactEditWidget(
      Size size, IconData icon, String st, void Function() onClick) {
    return GestureDetector(
      onTap: onClick,
      child: contactWidget(size, icon, st),
    );
  }
}

class AccountDescriptionDetailWidget extends StatelessWidget {
  const AccountDescriptionDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boxWidget(
                constraints: constraints,
                size: size,
                height: constraints.maxHeight * 0.165,
                child: Text(
                  Preferences.bio!,
                  style: TextStyle(fontSize: 16.0, fontFamily: "Paytone One"),
                ),
              ),
              boxWidget(
                constraints: constraints,
                size: size,
                height: constraints.maxHeight * 0.275,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    contactWidget(
                        size, Icons.date_range, Preferences.getDOB()!),
                    contactWidget(size, Icons.mail, Preferences.getEmail()!),
                    contactWidget(
                        size, Icons.phone, Preferences.getPhoneNumber()!),
                    contactWidget(size, Icons.home, Preferences.getAddress()!)
                  ],
                ),
              ),
              boxWidget(
                  constraints: constraints,
                  size: size,
                  height: constraints.maxHeight * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [...buildSocialConnectionsList(size)],
                  ))
            ],
          );
        },
      ),
    );
  }

  List<Widget> buildSocialConnectionsList(Size size) {
    return Preferences.socialConnections.map((url) {
      return contactWidget(size, FontAwesomeIcons.internetExplorer, "test");
    }).toList();
  }
}

Widget boxWidget(
    {required BoxConstraints constraints,
    required Size size,
    required double height,
    required Widget child}) {
  return Container(
    height: height,
    width: constraints.maxWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.03)),
        border: Border.all(
          width: 2,
          color: Color.fromARGB(200, 118, 136, 208),
        ),
        color: Color.fromRGBO(188, 220, 237, 1)),
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 4),
      child: SingleChildScrollView(
        child: child,
      ),
    ),
  );
}

Widget contactWidget(Size size, IconData icon, String text) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyBullet(),
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: constraints.maxWidth * 0.8,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0, fontFamily: "Paytone One"),
              ),
            ),
          )
        ],
      );
    },
  );
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
