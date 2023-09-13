import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = "http://192.168.40.189:5000/api/";

  Future<Map<String, dynamic>?> postData(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);

    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        print('Có lỗi xảy ra: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }
}
