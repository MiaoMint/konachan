import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class StroageUtils {
  static Future<String> getStoragePath() async {
    final dir = Directory(
        "${(await getApplicationDocumentsDirectory()).path}\\konachan");
    if (!dir.existsSync()) {
      dir.createSync();
    }
    return dir.path;
  }

  static late Box _settings;

  // 初始化
  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    _settings = await Hive.openBox("settings");
    initValue("downloadPath", await getStoragePath());
  }

  static initValue(String key, dynamic value) {
    if (!_settings.containsKey(key)) {
      _settings.put(key, value);
    }
  }

  static String get downloadPath => _settings.get("downloadPath");

  static set downloadPath(String path) {
    _settings.put("downloadPath", path);
  }
}
