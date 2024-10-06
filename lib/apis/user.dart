import 'package:body_king/services/api_response.dart';
import 'package:body_king/services/api_service.dart';

import '../../config.dart';
import '../../store/global.dart';
import 'models/user_res.dart';

class UserApi {
  final ApiService apiService;

  UserApi() : apiService = ApiService(baseUrl: Config.baseUrl3);

  Future<ApiResponse<GetUserDetailResponse>> fetchUserInfo() async {
    final user_id = GlobalState().user_id;
    print('request url /user/$user_id');
    final responce =  await apiService.get<GetUserDetailResponse>('/users/$user_id', GetUserDetailResponse.fromJson);
    return responce;
  }
}