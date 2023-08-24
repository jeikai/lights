import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

typedef ConfigMap = YamlMap;

class ConfigManager {
  static ConfigManager? _instance;

  static const NOTI_URL = "noti_url";
  static const TASK_URL = "task_url";
  static const POLLING_INTERVAL = "polling_interval";
  static const WHALE_MESSAGE = "whale_message";

  ConfigMap? _configMap;

  factory ConfigManager() {
    if (_instance == null) {
      _instance = ConfigManager._internal();
      return _instance!;
    }
    return _instance!;
  }

  ConfigManager._internal();

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

  int get pollingInterval => (configMap[POLLING_INTERVAL] as int);

  String get taskUrl => (configMap[TASK_URL]);

  String get notiUrl => (configMap[NOTI_URL]);

  YamlList get whaleMessage => (configMap[WHALE_MESSAGE] as YamlList);
}
