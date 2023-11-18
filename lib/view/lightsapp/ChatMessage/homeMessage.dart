import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Friends/AddPeople.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Doctor/ChatView.dart';

class MainMessage extends StatefulWidget {
  const MainMessage({super.key});

  @override
  State<MainMessage> createState() => _MainMessageState();
}

class _MainMessageState extends State<MainMessage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage == 1 ? ChatView() : AddPeople(),
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
                Icons.people,
                color: currentPage == 0 ? Colors.white : Colors.grey,
              ),
              label: 'people',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: currentPage == 1 ? Colors.white : Colors.grey,
              ),
              label: 'chat',
            ),
          ],
        ),
      ),
    );
  }
}
