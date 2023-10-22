import 'package:flutter/material.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/DataConfig.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Doctor/ChatCard.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_chat.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ListView(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                        size: screenWidth * 0.07,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/ava/' + (Preferences.getAva() ?? '')))),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Your doctors',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'Paytone One',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...List.generate(DataConfig.user.length, (index) {
                  var user = DataConfig.user.elementAt(index);
                  return ChatCard(
                    ava: user['image'],
                    name: user['name'],
                    newestMessage: user['newestMessage'],
                    path: user['path'],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
