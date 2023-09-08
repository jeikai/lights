import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// class Api {
//   static const Url = "https://192.168.40.189/api/";
//   static addUser(Map data) async {
//     var url = Uri.parse("${Url}add_user");
//     try {
//       final res = await http.post(url, body: data);
//       if (res.statusCode == 200) {
//       } else {}
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }

class Api {
  static String baseUrl = "http://10.0.2.16:5000/api/";

  Future<void> postData(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);

    try {
      // Chuyển đổi dữ liệu thành JSON string
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
      };
      print(jsonData);
      final response = await http
          .post(uri, headers: headers, body: jsonData)
          .timeout(Duration(seconds: 5));
      print("haha2");
      // if (response.statusCode == 200) {
      //   var jsonResponse = jsonDecode(response.body);
      //   print(jsonResponse);
      //   print('Dữ liệu đã được gửi thành công.');`
      // } else {
      //   // Xử lý lỗi nếu có
      //   print('Có lỗi xảy ra: ${response.statusCode}');
      // }
    } catch (e) {
      print('Lỗi: $e');
    }
  }
}
