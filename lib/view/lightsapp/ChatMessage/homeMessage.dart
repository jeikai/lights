import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Friends/AddPeople.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Doctor/ChatView.dart';

class mainMessage extends StatefulWidget {
  const mainMessage({super.key});

  @override
  State<mainMessage> createState() => _mainMessageState();
}

class _mainMessageState extends State<mainMessage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage == 0 ? ChatView() : AddPeople(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          backgroundColor: Colors.black,
          currentIndex: currentPage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: currentPage == 0 ? Colors.white : Colors.grey,
              ),
              label: 'chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: currentPage == 1 ? Colors.white : Colors.grey,
              ),
              label: 'people',
            ),
          ],
        ),
      ),
    );
  }
}
