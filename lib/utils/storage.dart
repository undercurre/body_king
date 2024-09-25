import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // 创建一个私有的静态实例
  static final LocalStorage _instance = LocalStorage._internal();

  // 工厂构造函数，返回单例实例
  factory LocalStorage() {
    return _instance;
  }

  // 私有的内部构造函数
  LocalStorage._internal();

  static SharedPreferences? _prefs;

  // 初始化 SharedPreferences 实例
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 设置字符串值
  Future<void> set(String key, dynamic value) async {
    if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs?.setStringList(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }

  // 获取字符串值
  String? get(String key) {
    return _prefs?.getString(key);
  }

  // 清除所有偏好设置
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
