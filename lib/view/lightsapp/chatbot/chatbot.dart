import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'chatmessage.dart';
import 'package:flutter/services.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final List<chatmessage> _message = [];
  bool _isTyping = false;

  //Dùng biến late để cho biết sau khi khai báo thì khởi tạo
  late OpenAI? chatGPT;
  StreamSubscription? _subscription;

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: Duration(milliseconds: 100000)),
      enableLog: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    chatmessage message = chatmessage(text: _controller.text, sender: "user");
    setState(() {
      _message.insert(0, message);
      _isTyping = true;
    });
    _controller.clear();

    final request = CompleteText(
      prompt: message.text,
      model: TextDavinci3Model(),
      maxTokens: 200,
    );

    try {
      final response = await chatGPT!.onCompletion(request: request);
      Vx.log(response?.choices[0].text);
      print(response);
      insertNewData(response!.choices[0].text, isImage: false);
    } catch (e) {
      print("Lỗi khi gửi yêu cầu đến OpenAI: $e");
    }
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
    final vietnameseFormatter = FilteringTextInputFormatter.allow(
      RegExp(r'[a-zA-Z\u00E0-\u1EF3\s]'),
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintText: "Điền tin nhắn",
            ),
            inputFormatters: [vietnameseFormatter],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: Color(0xFFB8BCDF),),
          onPressed: () {
            _sendMessage();
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
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8), // Để tạo khoảng cách giữa ảnh và text
            Text(
              "Cá voi light's",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Paytone One',
                fontWeight: FontWeight.w300,
              ),
            ),
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
                  padding: Vx.m8,
                  itemCount: _message.length,
                  itemBuilder: (context, index) {
                    return _message[index];
                  },
                ),
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
