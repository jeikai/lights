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
    print(uri);
    var response = await http.post(uri,
        headers: {'Context-Type': 'application/json'},
        body: data);
    var json = jsonDecode(response.body);
    print("haha");
    print(json);
    // if (response.statusCode == 200) {
    //   // Xử lý dữ liệu ở đây nếu cần
    //   print('Dữ liệu đã được gửi thành công.');
    // } else {
    //   // Xử lý lỗi nếu có
    //   print('Có lỗi xảy ra: ${response.statusCode}');
    // }
  }
}
