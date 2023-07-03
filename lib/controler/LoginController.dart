

class LoginController {
  static LoginController _instance = new LoginController._internal();
  static final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  factory LoginController() {
    return _instance;
  }

  LoginController._internal();

  void doLogin(Account account) async {
    bool check = validate(account);
    if(check) {
      //Do something for Login
    }
  }

  bool validate(Account account) {
    if (account.password == null && account.name == null) return false;
    if (validateStructure(account.name!) && validateStructure(account.password!)) return true;
    return true;
  }

  bool validateStructure(String value){
    return regex.hasMatch(value);
  }
}

class Account {
  String? name;
  String? password;

  Account(this.name, this.password);
}