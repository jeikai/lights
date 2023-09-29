import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = "http://192.168.66.64:5000/api/";

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

  Future<Map<String, dynamic>?> getDataById(String path, String id) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        print('Có lỗi xảy ra: ${response.statusCode}');
        if (response.statusCode == 500) {
          print(response.body);
        }
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> pushDataUpdate(
      String path, String id, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.put(uri, headers: headers, body: jsonData);
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
  Future<List<dynamic>?> getData(String path) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> jsonDataList = jsonDecode(response.body);
        return jsonDataList;
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
