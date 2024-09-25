import 'package:body_king/utils/storage.dart';

class GlobalManager {
  static final GlobalManager _instance = GlobalManager._internal();

  factory GlobalManager() {
    return _instance;
  }

  GlobalManager._internal();

  String? _token;

  // 获取 token
  String? get token => _token;

  // 初始化，加载数据
  Future<void> init() async {
    _token = LocalStorage().get('token');
  }
}
