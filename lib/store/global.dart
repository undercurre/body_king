import 'package:body_king/models/user_info.dart';
import 'package:flutter/cupertino.dart';

import '../utils/storage.dart';

class GlobalState with ChangeNotifier {
  String? _token;
  UserInfo? _userInfo;

  String? get token => _token;
  UserInfo? get userInfo => _userInfo;

  Future<void> init() async {
    _token = LocalStorage().get('token');
    Map<String, dynamic>? userInfo = LocalStorage().get('userInfo');
    if (userInfo != null) {
      _userInfo = UserInfo.fromJson(userInfo); // 确保UserInfo类有fromJson方法
    }
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    await LocalStorage().set('token', token);
    notifyListeners();
  }

  Future<void> setUserInfo(UserInfo userInfo) async {
    _userInfo = userInfo;
    await LocalStorage().set('userInfo', userInfo);
    notifyListeners();
  }

  Future<void> clear() async {
    _token = null;
    _userInfo = null;
    await LocalStorage().clear();
    notifyListeners();
  }
}