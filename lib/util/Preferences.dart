import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Lưu dữ liệu người dùng
  static Future setUsername(String username) async =>
      await _preferences?.setString("username", username);

  static String? getUsername() => _preferences?.getString("username");

  static Future setId(String id) async =>
      await _preferences?.setString("id", id);

  static String? getId() => _preferences?.getString("id");

  static Future setEmail(String email) async =>
      await _preferences?.setString("email", email);

  static String? getEmail() => _preferences?.getString("email");

  static Future setPhoneNumber(String phone) async =>
      await _preferences?.setString("phoneNumber", phone);

  static String? getPhoneNumber() => _preferences?.getString("phoneNumber");

  static Future setDOB(String id) async =>
      await _preferences?.setString("DOB", id);

  static String? getDOB() => _preferences?.getString("DOB");

  static Future setAddress(String id) async =>
      await _preferences?.setString("address", id);

  static String? getAddress() => _preferences?.getString("address");

  // Dữ liệu cho đăng ký
  static Future setRegisUsername(String username) async =>
      await _preferences?.setString("regisUsername", username);

  static String? getRegisUsername() => _preferences?.getString("regisUsername");

  static Future setRegisPhonenumber(String username) async =>
      await _preferences?.setString("regisPhonenumber", username);

  static String? getRegisPhonenumber() =>
      _preferences?.getString("regisPhonenumber");

  static Future setRegisEmail(String username) async =>
      await _preferences?.setString("regisEmail", username);

  static String? getRegisEmail() => _preferences?.getString("regisEmail");

  static Future setRegisAddress(String username) async =>
      await _preferences?.setString("regisAddress", username);

  static String? getRegisAddress() => _preferences?.getString("regisAddress");
}
