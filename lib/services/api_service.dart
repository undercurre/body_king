import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../apis/models/auth_res.dart';
import '../config.dart';
import '../main.dart';
import '../store/global.dart';
import 'JSONSerializable.dart';
import 'api_response.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late String baseUrl;

  static const loginEndPoint = '/auth/login';

  factory ApiService({String? baseUrl}) {
    if (baseUrl != null) {
      _instance.baseUrl = baseUrl;
    } else if (_instance.baseUrl.isEmpty) {
      _instance.baseUrl = Config.baseUrl;
    }
    return _instance;
  }

  ApiService._internal() : baseUrl = Config.baseUrl;

  Future<void> _saveLoginInfo(http.Response response) async {
    List<Future<void>> futures = [];
    final cookies = response.headers['set-cookie'];
    if (cookies != null) {
      futures.add(GlobalState().setCookie(cookies));
    }
    final jsonResponse = json.decode(response.body);
    final apiResponse = ApiResponse<LoginResponse>.fromJson(
      jsonResponse,
          (data) => LoginResponse.fromJson(data),
    );

    futures.add(GlobalState().setToken(apiResponse.data.access_token));
    futures.add(GlobalState().setUserId(apiResponse.data.user_id));
    await Future.wait(futures);
  }

  Future<ApiResponse<T>> get<T extends JsonSerializable>(
      String endpoint, T Function(Map<String, dynamic>) fromJsonT) async {
    return _sendRequest(
        () => http.get(Uri.parse('$baseUrl$endpoint'), headers: {
              'Authorization': 'Bearer ${GlobalState().token}',
            }),
        fromJsonT, endpoint);
  }

  Future<ApiResponse<T>> post<T extends JsonSerializable>(
      String endpoint,
      Map<String, dynamic> data,
      T Function(Map<String, dynamic>) fromJsonT) async {
    final cookie = GlobalState().cookie ?? '';
    return _sendRequest(
            () => http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json', 'Cookie': cookie, 'Authorization': 'Bearer ${GlobalState().token}'},
      body: json.encode(data),
    ), fromJsonT, endpoint);
  }

  Future<ApiResponse<T>> uploadFile<T extends JsonSerializable>(
      String endpoint,
      File file,
      T Function(Map<String, dynamic>) fromJsonT,
      {Map<String, String>? fields}) async {
    final cookie = GlobalState().cookie ?? '';
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));
    request.headers['Cookie'] = cookie;
    request.headers['Authorization'] = 'Bearer ${GlobalState().token}';

    // 添加文件
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    // 添加额外的表单字段
    if (fields != null) {
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401) {
      // Refresh token
      if (await _refreshToken()) {
        final newStreamedResponse = await request.send();
        final newResponse = await http.Response.fromStream(newStreamedResponse);
        return _processResponse<T>(newResponse, fromJsonT, endpoint);
      } else {
        throw Exception('Failed to refresh token');
      }
    }
    return _processResponse<T>(response, fromJsonT, endpoint);
  }

  Future<ApiResponse<T>> _sendRequest<T extends JsonSerializable>(
      Future<http.Response> Function() requestFn,
      T Function(Map<String, dynamic>) fromJsonT, String endpoint) async {
    final response = await requestFn();
    if (response.statusCode == 401) {
      // Refresh token
      if (await _refreshToken()) {
        final newResponse = await requestFn();
        return _processResponse<T>(newResponse, fromJsonT, endpoint);
      } else {
        MyApp.navigatorKey.currentState?.pushReplacementNamed('/login');
        throw Exception('Failed to refresh token');
      }
    }
    return _processResponse<T>(response, fromJsonT, endpoint);
  }

  Future<bool> _refreshToken() async {
    final cookie = GlobalState().cookie ?? '';

    final response = await http.post(
        Uri.parse('${Config.baseUrl}/auth/refresh-token'),
        headers: {'Content-Type': 'application/json', 'Cookie': cookie});

    if (response.statusCode == 200) {
      final jsonResponse =
          json.decode(response.body) as ApiResponse<RefreshTokenResponce>;
      GlobalState().setToken(jsonResponse.data.access_token);
      return true;
    } else {
      return false;
    }
  }

  Future<ApiResponse<T>> _processResponse<T extends JsonSerializable>(
      http.Response response, T Function(Map<String, dynamic>) fromJsonT, String endpoint) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (endpoint == loginEndPoint) {
        _saveLoginInfo(response);
      }
      if (kDebugMode) {
        print('Http Response: ${json.decode(response.body)}');
      }
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponse<T>.fromJson(jsonResponse, fromJsonT);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
