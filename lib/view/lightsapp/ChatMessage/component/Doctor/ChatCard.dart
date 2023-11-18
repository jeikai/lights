import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatCard extends StatelessWidget {
  final String ava;
  final String name;
  final String newestMessage;
  final String path;

  ChatCard({
    required this.ava,
    required this.name,
    required this.newestMessage,
    required this.path
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(
            path);
        try {
          // ignore: deprecated_member_use
          await launch(url.toString());
        } catch (e) {
          print('Error: $e');
        }
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
      ),
    );
  }
}
