import 'package:flutterapp/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setupUser(String id) async {
    Map<String, dynamic>? res = await Api().getDataById("user/getData", id);
    if (res?["message"]) {
      await Preferences.setBio(res?["userData"]["bio"]);
      await Preferences.setSocialConnections(
          res?["userData"]["socialConnections"]);
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

  static String? getUsername() => _preferences?.getString("username");

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

  static String? getPhoneNumber() => _preferences?.getString("phoneNumber");

  static Future setDOB(String id) async =>
      await _preferences?.setString("DOB", id);

  static Future setDOBUpdate(String email) async {
    await _preferences?.setString("DOB", email);
    //TODO: update date of birth
    Map<String, dynamic> data = {"DOB": email};
    var res = await Api().pushDataUpdate("user/update-dob", getId()!, data);
    print(res);
  }

  static String? getDOB() => _preferences?.getString("DOB");

  static Future setAddress(String id) async =>
      await _preferences?.setString("address", id);

  static Future setAddressUpdate(String email) async {
    await _preferences?.setString("address", email);
    //TODO: update address
    Map<String, dynamic> data = {"address": email};
    var res = await Api().pushDataUpdate("user/update-address", getId()!, data);
    print(res);
  }

  static String? getAddress() => _preferences?.getString("address");

  static String? get bio => _preferences?.getString("bio");

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

  static Future setSocialConnectionsUpdate(
      List<String> socialConnections) async {
    await _preferences?.setStringList("socialConnections", socialConnections);
    //TODO: update social connections
    Map<String, dynamic> data = {"bio": socialConnections};
    var res =
        await Api().pushDataUpdate("userdata/update-social", getId()!, data);
    print(res);
  }

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
