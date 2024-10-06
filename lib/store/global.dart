import 'package:body_king/models/user_info.dart';
import 'package:flutter/cupertino.dart';

import '../utils/storage.dart';

class GlobalState with ChangeNotifier {
  static final GlobalState _instance = GlobalState._internal();

  factory GlobalState() {
    return _instance;
  }

  GlobalState._internal();

  String? _token;
  UserInfo? _userInfo;
  String? _cookie;
  String? _user_id;
  bool _isDarkMode = false;
  String _avatar_url = 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg';

  String? get token => _token;
  UserInfo? get userInfo => _userInfo;
  String? get cookie => _cookie;
  String? get user_id => _user_id;
  bool get isDarkMode => _isDarkMode;
  String get avatar_url => _avatar_url;

  Future<void> init() async {
    _token = LocalStorage().get('token');
    _user_id = LocalStorage().get('user_id').toString();
    _cookie = LocalStorage().get('cookie');
    String? storage_avatar_url = LocalStorage().get('avatar_url');
    if (storage_avatar_url != null) {
      _avatar_url = storage_avatar_url;
    }
    Map<String, dynamic>? userInfo = LocalStorage().get('userInfo');
    if (userInfo != null) {
      _userInfo = UserInfo.fromJson(userInfo); // 确保UserInfo类有fromJson方法
    }
    bool? darkMode = LocalStorage().get('darkMode');
    if (darkMode != null) {
      _isDarkMode = darkMode;
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

  Future<void> setCookie(String cookie) async {
    _cookie = cookie;
    await LocalStorage().set('cookie', cookie);
    notifyListeners();
  }

  Future<void> setUserId(String userId) async {
    _user_id = userId;
    await LocalStorage().set('user_id', userId);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await LocalStorage().set('dark_mode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setAvatar(String url) async {
    _avatar_url = url;
    await LocalStorage().set('avatar_url', url);
    notifyListeners();
  }

  Future<void> clear() async {
    _token = null;
    _userInfo = null;
    _user_id = null;
    _cookie = null;
    _avatar_url = 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg';
    await LocalStorage().clear();
    notifyListeners();
  }
}