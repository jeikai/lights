import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

typedef ConfigMap = YamlMap;

class ConfigManager {
  static ConfigManager? _instance;

  static const NOTI_URL = "noti_url";
  static const TASK_URL = "task_url";

  ConfigMap? _configMap;

  factory ConfigManager() {
    if (_instance == null) {
      _instance = ConfigManager._internal();
      return _instance!;
    }
    return _instance!;
  }

  ConfigManager._internal() {}

  Future<void> setup() async {
    await loadConfig();
  }

  String? getConfig(String configName) {
    return configMap[configName];
  }

  Future<void> loadConfig() async {
    final String configString =
        await rootBundle.loadString("assets/config.yml");
    final ConfigMap configMap = loadYaml(configString);

    _configMap = configMap;
  }

  ConfigMap get configMap => _configMap ?? YamlMap();
}
