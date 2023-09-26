import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/chatDetail.dart';

class ChatCard extends StatelessWidget {
  final String ava;
  final String name;
  final String newestMessage;
  final String time;

  ChatCard({
    required this.ava,
    required this.name,
    required this.newestMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetail(
          name: name,
          image: ava,
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
              image: AssetImage(ava),
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          newestMessage,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        trailing: Text(time),
      ),
    );
  }
}
