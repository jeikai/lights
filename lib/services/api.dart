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
  static String baseUrl = "http://192.168.40.189/api/";

  Future<void> postData(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);

    try {
      // Chuyển đổi dữ liệu thành JSON string
      String jsonData = jsonEncode(data);
      var response = await http.post(uri,
          // headers: {'Content-Type': 'application/json'},
           body: jsonData);
      print(response);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print('Dữ liệu đã được gửi thành công.');
      } else {
        // Xử lý lỗi nếu có
        print('Có lỗi xảy ra: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }
}
