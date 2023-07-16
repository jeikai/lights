import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static const Url = "https://192.168.40.189/api/";
  static addUser(Map data) async {
    var url = Uri.parse("${Url}add_user");
    try {
      final res = await http.post(url, body: data);
      if (res.statusCode == 200) {
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
