import 'dart:convert';
import 'dart:ffi';

import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/process/notification/NotificationManager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setupUser(String id) async {
    Map<String, dynamic>? res = await Api().getDataById("user/getData", id);
    if (res?["message"]) {
       Preferences.setBio(res?["userData"]["bio"]);
       print("pass 1");
       NotificationManager()
           .loadNotificationsFromLocalStorage(res?["userData"]["notifications"]);
       print("pass 2");
    }
  }

  // Lưu dữ liệu người dùng
  static Future setUsername(String username) async =>
      await _preferences?.setString("username", username);

  static Future setUsernameUpdate(String username) async {
    await setUsername(username);
    //TODO: update username
    Map<String, dynamic> data = {"username": username};
    var res = await Api().pushDataUpdate("user/update-name", getId()!, data);
    print(res);
  }

  static String getUsername() => _preferences?.getString("username") ?? "";
  static Future setAva(String id) async =>
      await _preferences?.setString("ava", id);

  static String getAva() => _preferences?.getString("ava") ?? "";
  static Future setId(String id) async =>
      await _preferences?.setString("id", id);

  static String? getId() => _preferences?.getString("id");

  static Future setEmail(String email) async =>
      await _preferences?.setString("email", email);

  static Future setMailUpdate(String email) async {
    await _preferences?.setString("email", email);
    //TODO: update email
  }

  static String? getEmail() => _preferences?.getString("email");

  static Future setPhoneNumber(String phone) async =>
      await _preferences?.setString("phoneNumber", phone);

  static Future setPhoneUpdate(String email) async {
    await _preferences?.setString("phoneNumber", email);
    //TODO: update phone
    Map<String, dynamic> data = {"phoneNumber": email};
    var res = await Api().pushDataUpdate("user/update-phone", getId()!, data);
    print(res);
  }

  static String getPhoneNumber() => _preferences?.getString("phoneNumber") ?? "";

  static Future setDOB(String id) async =>
      await _preferences?.setString("DOB", id);

  static Future setDOBUpdate(String email) async {
    await _preferences?.setString("DOB", email);
    //TODO: update date of birth
    Map<String, dynamic> data = {"DOB": email};
    var res = await Api().pushDataUpdate("user/update-dob", getId()!, data);
    print(res);
  }

  static String getDOB() => _preferences?.getString("DOB") ?? "";

  static Future setAddress(String id) async =>
      await _preferences?.setString("address", id);

  static Future setAddressUpdate(String email) async {
    await _preferences?.setString("address", email);
    //TODO: update address
    Map<String, dynamic> data = {"address": email};
    var res = await Api().pushDataUpdate("user/update-address", getId()!, data);
    print(res);
  }

  static String getAddress() => _preferences?.getString("address") ?? "";

  static String get bio => _preferences?.getString("bio") ?? "";

  static Future<bool>? setBio(String bio) =>
      _preferences?.setString("bio", bio);

  static Future setBioUpdate(String email) async {
    await _preferences?.setString("bio", email);
    //TODO: update bio
    Map<String, dynamic> data = {"bio": email};
    var res = await Api().pushDataUpdate("userdata/update-bio", getId()!, data);
    print(res);
  }

  static List<String> get socialConnections =>
      _preferences?.getStringList("socialConnections") ?? [];

  static Future<bool>? setSocialConnections(List<String> socialConnections) =>
      _preferences?.setStringList("socialConnections", socialConnections);

  static Future setSocialConnectionsUpdate(List<String> socialConnections) async {
    await _preferences?.setStringList("socialConnections", socialConnections);
    //TODO: update social connections
    Map<String, dynamic> data = {"bio": socialConnections};
    var res =
    await Api().pushDataUpdate("userdata/update-social", getId()!, data);
    print(res);
  }
  static Future setForgetId(String username) async =>
      await _preferences?.setString("forgetId", username);

  static String getForgetId() => _preferences?.getString("forgetId") ?? "";

  // Dữ liệu cho đăng ký
  static Future setRegisUsername(String username) async =>
      await _preferences?.setString("regisUsername", username);

  static String getRegisUsername() => _preferences?.getString("regisUsername") ?? "";

  static Future setRegisPhonenumber(String username) async =>
      await _preferences?.setString("regisPhonenumber", username);

  static String getRegisPhonenumber() =>
      _preferences?.getString("regisPhonenumber") ?? "";

  static Future setRegisEmail(String username) async =>
      await _preferences?.setString("regisEmail", username);

  static String getRegisEmail() => _preferences?.getString("regisEmail") ?? "";

  static Future setRegisAddress(String username) async =>
      await _preferences?.setString("regisAddress", username);

  static String getRegisAddress() => _preferences?.getString("regisAddress") ?? "";

  static List<dynamic>? getTasks() {
    return jsonDecode(_preferences!.getString("tasks")!);
  }

  static Future<void> setTasks(List<dynamic> tasks) async {
    String encoded = jsonEncode(tasks);
    await _preferences?.setString("tasks", encoded);
    return;
  }

  static String? getNotis() {
    return _preferences!.getString("notificationList");
  }

  static Future<void> setNotis(String json) async {
    await _preferences?.setString('notificationList', json);
    return;
  }

  static String formatDate(DateTime time) {
    return DateFormat('yyyy-MM-dd').format(time);
  }

  static Future setBgMusic(bool isMute) async =>
      await _preferences?.setBool("bgMusic", isMute);

  static bool? getBgMusic() => _preferences?.getBool("bgMusic") ?? true;
}