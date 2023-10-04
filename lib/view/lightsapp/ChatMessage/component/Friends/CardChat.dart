import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Friends/detailChat.dart';
import 'package:url_launcher/url_launcher.dart';

class CardChat extends StatelessWidget {
  final String id;
  final String name;

  CardChat({
    required this.id,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_) => detailChat(
          name: name,
          id: id,
          image: 'assets/images/bg_chat.png',
        )));
      },
      child: ListTile(
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_chat.png'),
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Id: " + id,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
