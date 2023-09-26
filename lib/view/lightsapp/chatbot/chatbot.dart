import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'chatmessage.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/view/lightsapp/chatbot/threedots.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final List<chatmessage> _message = [];
  final _formKey = GlobalKey<FormState>();
  bool _isTyping = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    chatmessage message = chatmessage(text: _controller.text, sender: "user");
    setState(() {
      _message.insert(0, message);
      _isTyping = true;
    });
    Map<String, dynamic> request = {
      "message": _controller.text,
    };
    _controller.clear();
    var response = await Api().postData("chatbot", request);
    insertNewData(response!["response"]);
  }

  void insertNewData(String response, {bool isImage = false}) {
    chatmessage Message = chatmessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );
    setState(() {
      _isTyping = false;
      _message.insert(0, Message);
    });
  }

  Widget InputText() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 240, 253, 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (value) => _sendMessage(),
                validator: (value) {
                  if (value!.isEmpty) {
                    ToastNoti.show("Vui lòng nhập gì đó");
                  }
                },
                onTapOutside: (event) => {FocusScope.of(context).unfocus()},
                decoration: InputDecoration(
                  hintText: "Điền tin nhắn",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(90, 106, 176, 1),
                    fontSize: 20.0,
                    fontFamily: 'Paytone One',
                    fontWeight: FontWeight.w300,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                style: TextStyle(
                  color: Color.fromRGBO(90, 106, 176, 1),
                  fontSize: 20.0,
                  fontFamily: 'Paytone One',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.send,
            color: Color.fromRGBO(185, 188, 223, 1),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _sendMessage();
            } else {
              print("Không hợp lệ");
            }
          },
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5C6E7),
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/ava.png'),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cá voi Light\'s',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_chat.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Điều chỉnh khả năng co giãn của widget bên trong
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
                  itemBuilder: (context, index) {
                    return _message[index];
                  },
                  itemCount: _message.length,
                ),
              ),
              if (_isTyping) const ThreeDots(),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: InputText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
