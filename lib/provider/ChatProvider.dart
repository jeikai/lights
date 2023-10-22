import 'package:flutter/foundation.dart';

import '../view/lightsapp/ChatMessage/component/Friends/ibMessage.dart';

class ChatProvider extends ChangeNotifier {
  final List<IbMessage> _messages = [];
  List<IbMessage> get messages => _messages;
   addMessage(IbMessage message) {
    _messages.insert(0, message);
    notifyListeners(); // Thông báo cho người nghe sự kiện về sự thay đổi trạng thái
  }
}