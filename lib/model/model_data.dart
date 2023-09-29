

class User {
  // final String? name;
  // final String? phone_Number;
  // final String? address;
  String? email;
  String? password;

  User(this.email, this.password);
}

class TaskData {
  final String? taskDes;
  final double? percent;

  TaskData({this.taskDes, this.percent});

// static TaskData fromMap(Map<dynamic, dynamic> map) async {
//   TaskData data;
//   Map<String,dynamic> taskDetail = await Api().
//
//   return data;
// }
}
