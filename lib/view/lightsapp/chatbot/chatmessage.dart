import 'package:custom_clippers/custom_clippers.dart';
import "package:flutter/material.dart";

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
    this.isImage = false,
  }) : super(key: key); 

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    final isUser = sender == "user";
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: ClipPath(
            clipper: isUser
                ? LowerNipMessageClipper(MessageType.send)
                : UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isUser
                    ? Color.fromRGBO(149, 147, 212, 1)
                    : Color.fromRGBO(250, 241, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  )
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: isUser ? Colors.white : Colors.black,
                    fontFamily: 'Paytone One',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
