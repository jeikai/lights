import 'package:flutter/foundation.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/TaskManager.dart';

class CalenderController {
  static int emotionToInt(String emotion) {
    switch (emotion) {
      case "CucBuon":
        return 0;
      case "Buon":
        return 1;
      case "BinhThuong":
        return 2;
      case "Vui":
        return 3;
      case "CucVui":
        return 4;
      default:
        throw Exception("Unknown Emotion to convert to int: $emotion");
    }
  }

  static Future<void> updateEmotions(String date, String emotion) async {
    Map<String, dynamic> data = {
      "userId": Preferences.getId(),
      "date": date,
      "updateFields": {"emotion": emotion}
    };
    Map<String, dynamic> data2 = {
      "userId": Preferences.getId(),
      "emotion": emotionToInt(emotion)
    };
    Map<String, dynamic> data3 = {
      "userId": Preferences.getId(),
    };
    if (!kReleaseMode) {
      print("Putting to Update User Date Data");
    }
    var temp1 =
        await Api().pushDataUpdateWithoutId("update-user-date-activity", data);
    if (!kReleaseMode) {
      print("Data: \n $temp1");
    }
    if (!kReleaseMode) {
      print("Putting to Update User Emotion Data");
    }
    var temp2 = await Api().postData("emotion", data2);
    if (!kReleaseMode) {
      print("Data: \n $temp2");
    }
    if (!kReleaseMode) {
      print("Putting to Update User Depression");
    }
    var temp3 = await Api().postData("updateLevelDepression", data3);
    if (!kReleaseMode) {
      print("Data: \n $temp3");
    }
    await TaskManager.updateTask();
    return;
  }

  static Future<void> putDataWriting(
      DateTime time, String title, String story) async {
    Map<String, dynamic> data = {
      "userId": Preferences.getId(),
      "date": Preferences.formatDate(time),
      "updateFields": {"title": title, "story": story}
    };
    await Api().pushDataUpdateWithoutId("update-user-date-activity", data);
    return;
  }

  static Future<String> putDataImage(DateTime time, String path) async {
    String? a = await Api().uploadImage(path);
    if (a == null) throw Exception("Some Error in uploading Image");
    Map<String, dynamic> data = {
      "userId": Preferences.getId(),
      "date": Preferences.formatDate(time),
      "updateFields": {"image": a}
    };
    await Api().pushDataUpdateWithoutId("update-user-date-activity", data);
    return a;
  }
}
