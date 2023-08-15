import 'package:flutter/material.dart';
import 'package:flutterapp/util/ConfigManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Scaffold(
      body: A(),
    ),
  ));
}

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var manager = ConfigManager();
    manager.setup().then((value) {
      print(manager.getConfig(ConfigManager.TASK_URL));
      print(manager.getConfig(ConfigManager.NOTI_URL));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
