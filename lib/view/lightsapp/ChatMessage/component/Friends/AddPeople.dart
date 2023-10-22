import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/DataConfig.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/component/Friends/CardChat.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({Key? key}) : super(key: key);

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  Future<List> _getDataFromApi() async {
    final api = Api();
    final response = await api.getDataUsersById("user/getAllUser", Preferences.getId()!);
    return response ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_chat.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                        size: screenWidth * 0.07,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/user_icon.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'Paytone One',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FutureBuilder<List>(
                  future: _getDataFromApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final user = snapshot.data ?? [];
                      return Expanded(
                        child: ListView(
                          children: List.generate(user.length, (index) {
                            var userData = user[index];
                            return CardChat(
                              id: userData["_id"],
                              name: userData['name'],
                            );
                          }),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
