import 'package:flutter/material.dart';
class ChatDetail extends StatefulWidget {
  final String name;
  final String image;
  const ChatDetail({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.image),
                )
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 5,),
                const Text(
                  'Light\'s',
                  style: TextStyle(
                    fontFamily: 'Mistrully',
                    fontSize: 12,
                    color: Color.fromARGB(255, 195, 160, 212),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
