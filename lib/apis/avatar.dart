import 'dart:io';

import 'package:body_king/apis/models/avatar_res.dart';
import 'package:body_king/services/api_response.dart';
import 'package:body_king/services/api_service.dart';
import 'package:body_king/store/global.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class AvatarApi {
  final ApiService apiService;

  AvatarApi() : apiService = ApiService(baseUrl:  Config.baseUrl1);

  Future<ApiResponse<CreateAvatarResponse>> fetchCreateAvatar(String url) async {
    final data = {
      "user_id": GlobalState().user_id,
      "avatar_url": url,
    };
    final response = await apiService.post('/user-avatar/create', data, CreateAvatarResponse.fromJson);
    return response;
  }

  Future<ApiResponse<GetAvatarResponse>> fetchGetAvatar() async {
    final user_id = GlobalState().user_id;
    final responce =  await apiService.get<GetAvatarResponse>('/user-avatar/$user_id', GetAvatarResponse.fromJson);
    return responce;
  }

  Future<ApiResponse<UploadAvatarResponse>> fetchUploadAvatar(File file) async {
    final fields = {
      'filename': 'avatar'
    };
    final responce =  await apiService.uploadFile<UploadAvatarResponse>('/user-avatar/upload', file, UploadAvatarResponse.fromJson, fields: fields);
    return responce;
  }
}