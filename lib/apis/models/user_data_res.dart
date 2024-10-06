import '../../services/JSONSerializable.dart';

class UserData implements JsonSerializable {
  final String id;
  final String user_id;
  final num step_count;
  final num weight;
  final String sleep_start_time;
  final String sleep_end_time;
  final num water_cups;
  final num drink_ml;
  final num code_lines;
  final num snack_calories;
  final num video_game_time;
  final num exercise_calories;
  final num music_time;
  final String created_at;
  final String updated_at;

  UserData({
    required this.id,
    required this.user_id,
    required this.step_count,
    required this.weight,
    required this.sleep_start_time,
    required this.sleep_end_time,
    required this.water_cups,
    required this.drink_ml,
    required this.code_lines,
    required this.snack_calories,
    required this.video_game_time,
    required this.exercise_calories,
    required this.music_time,
    required this.created_at,
    required this.updated_at,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        user_id: json['user_id'],
        step_count: json['step_count'],
        weight: json['weight'],
        sleep_start_time: json['sleep_start_time'],
        sleep_end_time: json['sleep_end_time'],
        water_cups: json['water_cups'],
        drink_ml: json['drink_ml'],
        code_lines: json['code_lines'],
        snack_calories: json['snack_calories'],
        video_game_time: json['video_game_time'],
        exercise_calories: json['exercise_calories'],
        music_time: json['music_time'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }

  @override
  UserData fromJson(Map<String, dynamic> json) {
    return UserData.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
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
      'created_at': created_at,
      'updated_at': updated_at
    };
  }
}

class CreateUserDataResponse implements JsonSerializable {
  final UserData userData;

  CreateUserDataResponse({required this.userData});

  factory CreateUserDataResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserDataResponse(userData: UserData.fromJson(json));
  }

  @override
  UserData fromJson(Map<String, dynamic> json) {
    return UserData.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'userData': userData.toJson(),
    };
  }
}

class GetUserDataByUserResponse implements JsonSerializable {
  final UserData userData;

  GetUserDataByUserResponse({required this.userData});

  factory GetUserDataByUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataByUserResponse(userData: UserData.fromJson(json));
  }

  @override
  GetUserDataByUserResponse fromJson(Map<String, dynamic> json) {
    return GetUserDataByUserResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'userData': userData.toJson(),
    };
  }
}
