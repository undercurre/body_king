import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'JSONSerializable.dart';
import 'api_response.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final String baseUrl;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() : baseUrl = Config.baseUrl;

  Future<ApiResponse<T>> get<T extends JsonSerializable>(String endpoint, T Function(Map<String, dynamic>) fromJsonT) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return _processResponse<T>(response, fromJsonT);
  }

  Future<ApiResponse<T>> post<T extends JsonSerializable>(String endpoint, Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJsonT) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _processResponse<T>(response, fromJsonT);
  }

  ApiResponse<T> _processResponse<T extends JsonSerializable>(http.Response response, T Function(Map<String, dynamic>) fromJsonT) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
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
