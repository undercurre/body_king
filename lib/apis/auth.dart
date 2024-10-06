import 'package:body_king/config.dart';
import 'package:body_king/services/api_response.dart';
import 'package:body_king/apis/models/auth_res.dart';

import '../services/api_service.dart';

class AuthApi {
  final ApiService apiService;

  AuthApi() : apiService = ApiService(baseUrl: Config.baseUrl);

  Future<ApiResponse<LoginResponse>> login(String username, String password, String iv, String key) async {
    final data = {'username': username, 'password': password, 'iv': iv, 'key': key};
    final responce =  await apiService.post<LoginResponse>('/auth/login', data, LoginResponse.fromJson);
    return responce;
  }
  
  Future<ApiResponse<PublicKeyResponse>> getPublicKey() async {
    return await apiService.get('/auth/public-key', PublicKeyResponse.fromJson);
  }

// Add other authentication-related methods here, like register, logout, etc.
}
