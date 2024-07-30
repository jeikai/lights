import 'dart:convert';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/view/lightsapp/cardMenu/Card.dart';
import 'package:http/http.dart' as http;

class Api {
  // static String baseUrl = "https://lights-server-2r1w.onrender.com/api/";

  static String baseUrl = "http://192.168.31.194:5000/api/";

  Future<String?> uploadImage(String path) async {
    final Uri uri = Uri.parse(baseUrl + "upload");

    try {
      // Create a FormData object and attach the image and user ID.
      var request = http.MultipartRequest('POST', uri)
        ..fields['userId'] = Preferences.getId()!
        ..files.add(await http.MultipartFile.fromPath('image', path));

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully uploaded the image, parse the response.
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);

        if (data['status'] == true) {
          String imageUrl = data['url'];
          return imageUrl;
        } else {
          print('Có lỗi xảy ra: ${response.statusCode}');
          return null;
        }
      } else {
        print('Có lỗi xảy ra: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> postData(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<Map<String, dynamic>?> scanQR(String path, Map data) async {
    final Uri uri = Uri.parse(path);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.put(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        print('Có lỗi xảy ra: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }

  Future<List<dynamic>?> getDataMessage(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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

  Future<List<dynamic>?> postDataForTasks(String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<dynamic>?> getDataUsersById(String path, String id) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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

  Future<Map<String, dynamic>?> putDataById(String path, String id) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.put(uri, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<dynamic>?> getDataByIdForMissions(String path, String id) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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

  Future<List<dynamic>?> getDataByIdForChart(String path, String id) async {
    final Uri uri = Uri.parse(baseUrl + path + "/" + id);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<Map<String, dynamic>?> pushDataUpdateWithoutId(
      String path, Map data) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      String jsonData = jsonEncode(data);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response =
          await http.put(uri, headers: headers, body: jsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<Cardd>> getCards() async {
    List<dynamic> data =
        (await getDataById("getUserCard", Preferences.getId()!))!["userCards"]!;
    List<Cardd> res = [];
    for (int i = 0; i < data.length; i++) {
      res.add(Cardd.map(data[i]));
    }
    return res;
  }

  Future<Map<String, dynamic>?> updateCard(
    id,
    String text,
  ) async {
    Map<String, dynamic> data = {"id": id, "answer": text};
    return await pushDataUpdate("updateCard", id, data);
  }

  Future<List?> searchByName(String name) async {
    final Uri uri = Uri.parse(baseUrl + "searchByName");
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(uri,
          headers: headers, body: jsonEncode({"name": name}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> addFriend(String userId, String friendId) async {
    final Uri uri = Uri.parse(baseUrl + "addFriend");
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      await http.post(uri,
          headers: headers,
          body: jsonEncode({"userId": userId, "friendId": friendId}));
    } catch (e) {
      print('Error: $e');
    }
  }
}
