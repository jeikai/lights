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
  static String baseUrl = "http://192.168.124.64:5000/api/";

  Future<Map<String, dynamic>?> postData(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);

    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final http.Response response = await http
          .post(uri, headers: headers, body: jsonData)
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        // Phân tích chuỗi JSON thành một đối tượng Dart
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // print(jsonResponse["user"]);
        return jsonResponse;
      } else {
        // Xử lý lỗi nếu có
        print('Có lỗi xảy ra: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }
}
