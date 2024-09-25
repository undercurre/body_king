import '../../services/JSONSerializable.dart';

class LoginResponse implements JsonSerializable {
  final String access_token;

  LoginResponse({required this.access_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      access_token: json['access_token'],
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
