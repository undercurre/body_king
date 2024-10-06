import '../../services/JSONSerializable.dart';

class LoginResponse implements JsonSerializable {
  final String access_token;
  final String user_id;
  final String refresh_token;

  LoginResponse({required this.user_id, required this.access_token, required this.refresh_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      access_token: json['access_token'],
      user_id: json['user_id'],
      refresh_token: json['refresh_token'],
    );
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }
}

class PublicKeyResponse implements JsonSerializable {
  final String publicKey;

  PublicKeyResponse({required this.publicKey});

  factory PublicKeyResponse.fromJson(Map<String, dynamic> json) {
    return PublicKeyResponse(
      publicKey: json['publicKey'],
    );
  }

  @override
  PublicKeyResponse fromJson(Map<String, dynamic> json) {
    return PublicKeyResponse.fromJson(json);
  }
}

class RefreshTokenResponce implements JsonSerializable {
  final String access_token;

  RefreshTokenResponce({required this.access_token});

  factory RefreshTokenResponce.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponce(
      access_token: json['access_token'],
    );
  }

  @override
  RefreshTokenResponce fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponce.fromJson(json);
  }
}