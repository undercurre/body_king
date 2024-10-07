import 'package:body_king/apis/models/user_data_res.dart';
import 'package:body_king/services/api_service.dart';

import '../config.dart';
import '../services/api_response.dart';
import '../store/global.dart';

class UserDataApi {
  final ApiService apiService;

  UserDataApi() : apiService = ApiService(baseUrl: Config.baseUrl2);

  Future<ApiResponse<CreateUserDataResponse>> fetchCreateUserData({
    num? step_count,
    num? weight,
    DateTime? sleep_start_time,
    DateTime? sleep_end_time,
    num? water_cups,
    num? drink_ml,
    num? code_lines,
    num? snack_calories,
    num? video_game_time,
    num? exercise_calories,
    num? music_time,
  }) async {
    final data = {
      "user_id": GlobalState().user_id,
      'step_count': step_count,
      'weight': weight,
      'sleep_start_time': sleep_start_time,
      'sleep_end_time': sleep_end_time,
      'water_cups': water_cups,
      'drink_ml': drink_ml,
      'code_lines': code_lines,
      'snack_calories': snack_calories,
      'video_game_time': video_game_time,
      'exercise_calories': exercise_calories,
      'music_time': music_time,
    };
    final responce = await apiService.post<CreateUserDataResponse>(
        '/user-data', data, CreateUserDataResponse.fromJson);
    return responce;
  }

  Future<ApiResponse<GetUserDataByUserResponse>> fetchGetUserData() async {
    final user_id = GlobalState().user_id;
    final responce = await apiService.get<GetUserDataByUserResponse>(
        '/user-data/user/$user_id', GetUserDataByUserResponse.fromJson);
    return responce;
  }
}
