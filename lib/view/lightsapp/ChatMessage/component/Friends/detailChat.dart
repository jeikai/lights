import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/provider/ChatProvider.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'ibMessage.dart';

class detailChat extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  const detailChat(
      {Key? key, required this.id, required this.name, required this.image})
      : super(key: key);

  @override
  State<detailChat> createState() => _DetailChatState();
}

class _DetailChatState extends State<detailChat> {
  final TextEditingController _controller = TextEditingController();
  late IO.Socket socket;

  bool _isLoading = true;

  Future<void> connect() async {
    socket = IO.io('https://lights-server-2r1w.onrender.com', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });

    socket.connect();

    socket.onConnect((data) {
      print("Connected");
      socket.emit("add-user", Preferences.getId());
    });
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    socket.on('msg-receive', (data) {
      if (data != null && data.containsKey('msg')) {
        IbMessage message = IbMessage(
          text: data['msg'],
          isSender: false,
          time: data['time'],
        );
        Provider.of<ChatProvider>(context, listen: false).addMessage(message);
      } else {
        // Xử lý dữ liệu không hợp lệ hoặc trường hợp khác
        print('Received invalid data from the server.');
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  String formatTime(String timeString) {
    try {
      // Tách chuỗi thời gian
      final List<String> parts = timeString.split(' ');

      if (parts.length < 5) {
        return '';
      }

      // Lấy ngày, tháng, năm, giờ, phút, giây
      final String day = parts[2];
      final String month = parts[1];
      final String year = parts[3];
      final String time = parts[4];
      final String timeZone = parts[5];

      // Định dạng lại chuỗi thời gian
      final String formattedTime = '$day $month $year $time $timeZone';

      return formattedTime;
    } catch (e) {
      print('Error formatting time: $e');
      return '';
    }
  }

  void addData() async {
    Map data = {
      "from": Preferences.getId(),
      "to": widget.id,
    };
    var response = await Api().getDataMessage("getmsg", data);

    for (var messageData in response!) {
      final String formattedTime = formatTime(messageData["time"]);
      final DateTime parsedTime =
      DateFormat('dd MMM yyyy HH:mm:ss').parse(formattedTime);
      final DateTime adjustedTime = parsedTime.add(Duration(hours: 7));
      final String formattedMessageTime =
      DateFormat('dd MMM yyyy HH:mm:ss').format(adjustedTime);

      IbMessage message = IbMessage(
        text: messageData["message"],
        isSender: messageData["fromSelf"],
        time: formattedMessageTime,
      );

      Provider.of<ChatProvider>(context, listen: false).addMessage(message);
    }
  }

  @override
  void initState() {
    super.initState();
    connect();
    addData();
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
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('dd MMM yyyy HH:mm:ss').format(now);
      IbMessage message = IbMessage(
          text: _controller.text, isSender: true, time: formattedTime);
      Provider.of<ChatProvider>(context, listen: false).addMessage(message);
      socket.emit("send-msg",
          {"to": widget.id, "msg": _controller.text, "time": formattedTime});
    } else {
      ToastNoti.show("Gửi tin nhắn không thành công");
    }
    _controller.clear();
  }

  Widget inputText() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 240, 253, 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextFormField(
              controller: _controller,
              onFieldSubmitted: (value) => _sendMessage(),
              validator: (value) {
                if (value!.isEmpty) {
                  ToastNoti.show("Bạn chưa nhập gì");
                }
                return null;
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
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
        IconButton(
          icon: const Icon(
            Icons.send,
            color: Color.fromRGBO(185, 188, 223, 1),
          ),
          onPressed: () async {
            _sendMessage();
          },
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context,
              '/homeMessage'); // Điều hướng quay lại màn hình /homeMessage
          return false; // Chặn việc đóng màn hình
        },
        child: Scaffold(
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
                    ),
                  ),
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
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_chat.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Flexible(
                    child: Consumer<ChatProvider>(
                      builder: (_, provider, __) {
                        return ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                            bottom: 80,
                          ),
                          itemBuilder: (context, index) {
                            return provider.messages[index];
                          },
                          itemCount: provider.messages.length,
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: context.cardColor,
                    ),
                    child: inputText(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}