import 'package:yaml/yaml.dart';

class NotificationContent {
  bool isRead;
  String content;

  NotificationContent({required this.isRead, required this.content});

  NotificationContent.newContent()
      : isRead = false,
        content = "null";

  String toMap() {
    return "";
  }

  static NotificationContent fromMap(String string) {
    YamlMap map = loadYaml(string);
    return NotificationContent(isRead: map["isRead"], content: map["content"]);
  }
}
