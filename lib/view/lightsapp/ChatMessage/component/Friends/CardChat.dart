import 'package:flutter/material.dart';
import 'package:flutterapp/provider/ChatProvider.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Friends/detailChat.dart';
import 'package:provider/provider.dart';

class CardChat extends StatelessWidget {
  final String id;
  final String name;
  final String ava;
  CardChat({
    required this.id,
    required this.name,
    required this.ava
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (context) => ChatProvider(),
              child: detailChat(
                name: name,
                id: id,
                image: 'assets/images/ava/' + ava,
              ),
            ),
          ),
        );
      },
      child: ListTile(
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/ava/' + ava),
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
