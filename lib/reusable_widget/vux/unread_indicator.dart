import 'package:flutter/material.dart';
import 'package:flutterapp/util/Event.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';

class UnreadIndicator extends StatefulWidget {
  final double? width;
  final double? height;

  const UnreadIndicator({Key? key, this.height, this.width}) : super(key: key);

  @override
  _UnreadIndicatorState createState() => _UnreadIndicatorState();
}

class _UnreadIndicatorState extends State<UnreadIndicator> {
  late NotificationManager manager;
  int number = 0;

  @override
  void initState() {
    super.initState();
    manager = NotificationManager();
    manager.addListener((event) {
      print("listen");
      setState(() {
        number = manager.notificationUnreadCount;
        print(number);
      });
    }, Priorities.belowNormal);
  }

  @override
  Widget build(BuildContext context) {
    return number == 0
        ? Container()
        : CircleNumberWidget(
            number: this.number,
            height: widget.height,
            width: widget.width,
          );
  }
}

class CircleNumberWidget extends StatelessWidget {
  final int number;
  final double? width;
  final double? height;

  CircleNumberWidget({required this.number, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 60, // Adjust the size as needed
      height: height ?? 60, // Adjust the size as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Change the color as you like
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: Colors.white, // Change the text color as you like
            fontSize: (width ?? 60) / 2, // Change the font size as you like
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
