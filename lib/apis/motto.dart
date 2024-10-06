import 'package:body_king/apis/models/motto_res.dart';
import 'package:body_king/services/api_response.dart';
import 'package:body_king/services/api_service.dart';
import 'package:body_king/store/global.dart';

import '../config.dart';

class MottoApi {
  final ApiService apiService;

  MottoApi() : apiService = ApiService(baseUrl: Config.baseUrl2);

  Future<ApiResponse<CreateMottoResponse>> fetchCreateMotto(String motto) async {
    final data = {
      "user_id": GlobalState().user_id,
      "motto_text": motto,
    };
    final responce =  await apiService.post<CreateMottoResponse>('/mottos', data, CreateMottoResponse.fromJson);
    return responce;
  }

  Future<ApiResponse<GetMottoByUserResponse>> fetchGetMottos() async {
    final user_id = GlobalState().user_id;
    print('request url /mottos/user/$user_id');
    final responce =  await apiService.get<GetMottoByUserResponse>('/mottos/user/$user_id', GetMottoByUserResponse.fromJson);
    return responce;
  }
}