
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
class IbMessage extends StatefulWidget {
  const IbMessage({
    Key? key,
    required this.text,
    required this.isSender,
    required this.time,
  }) : super(key: key);

  final String text;
  final bool isSender;
  final String time;

  @override
  State<IbMessage> createState() => _IbMessageState();
}

class _IbMessageState extends State<IbMessage> {
  @override
  Widget build(BuildContext context) {
    final isUser = widget.isSender == true;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: isUser ? Colors.white : Colors.black,
                      fontFamily: 'Paytone One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8), // Khoảng cách giữa văn bản và thời gian
                  Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isUser ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
