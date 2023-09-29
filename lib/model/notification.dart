

class NotificationContent {
  bool isRead;
  String content;

  NotificationContent({required this.isRead, required this.content});

  NotificationContent.newContent()
      : isRead = false,
        content = "null";

  Map<String, dynamic> toMap() {
    return {"isRead": this.isRead, "content": this.content};
  }

  static NotificationContent fromMap(Map<String, dynamic> map) {
    return NotificationContent(isRead: map["isRead"], content: map["content"]);
  }
}
