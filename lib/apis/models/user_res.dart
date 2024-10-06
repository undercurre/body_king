import 'package:body_king/services/JSONSerializable.dart';

class UserDetail implements JsonSerializable {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final String created_at;
  final String updated_at;

  UserDetail(
      {required this.id,
        required this.username,
        required this.email,
        this.phone,
        required this.created_at,
        required this.updated_at});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }

  @override
  UserDetail fromJson(Map<String, dynamic> json) {
    return UserDetail.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}

class GetUserDetailResponse implements JsonSerializable {
  final UserDetail userDetail;

  GetUserDetailResponse({required this.userDetail});

  factory GetUserDetailResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDetailResponse(
      userDetail: UserDetail.fromJson(json),
    );
  }

  @override
  GetUserDetailResponse fromJson(Map<String, dynamic> json) {
    return GetUserDetailResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'userDetail': userDetail.toJson(),
    };
  }
}