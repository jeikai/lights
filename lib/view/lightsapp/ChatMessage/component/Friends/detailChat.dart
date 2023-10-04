import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'ibMessage.dart';

class detailChat extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  const detailChat(
      {Key? key, required this.id, required this.name, required this.image})
      : super(key: key);

  @override
  State<detailChat> createState() => _detailChatState();
}

class _detailChatState extends State<detailChat> {
  final TextEditingController _controller = TextEditingController();
  final List<IbMessage> _message = [];
  final _formKey = GlobalKey<FormState>();
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://192.168.40.189:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("add-user", Preferences.getId());
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
  }

  void AddData() async {
    Map data = {
      "from": Preferences.getId(),
      "to": widget.id,
    };
    var response = await Api().getDataMessage("getmsg", data);
    for (var messageData in response!) {
      IbMessage message = IbMessage(text: messageData["message"], isSender: messageData["fromSelf"]);
      setState(() {
        _message.insert(0, message);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    connect();
    AddData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    Map data = {
      "message": _controller.text,
      "from": Preferences.getId(),
      "to": widget.id
    };
    var response = await Api().postData("addmsg", data);
    if (response?["status"]) {
      IbMessage message =
          IbMessage(text: _controller.text, isSender: true);
      setState(() {
        _message.insert(0, message);
      });

      socket.emit("send-msg", {"to": widget.id, "msg": _controller.text});
    } else {
      ToastNoti.show("Gửi tin nhắn không thành công");
    }
    _controller.clear();
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
                    ToastNoti.show("Bạn chưa nhập gì");
                  }
                },
                onTapOutside: (event) => {FocusScope.of(context).unfocus()},
                decoration: InputDecoration(
                  hintText: "Nhập tin nhắn",
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
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.image),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
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
