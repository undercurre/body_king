import '../../services/JSONSerializable.dart';

class UserAvatar implements JsonSerializable {
  final num id;
  final String user_id;
  final String avatar_url;
  final String created_at;
  final String updated_at;

  UserAvatar(
      {required this.id,
      required this.user_id,
      required this.avatar_url,
      required this.created_at,
      required this.updated_at});

  factory UserAvatar.fromJson(Map<String, dynamic> json) {
    return UserAvatar(
        id: json['id'],
        user_id: json['user_id'],
        avatar_url: json['avatar_url'],
        created_at: json['created_at'],
        updated_at: json['created_at']);
  }

  @override
  UserAvatar fromJson(Map<String, dynamic> json) {
    return UserAvatar.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'avatar_url': avatar_url,
      'created_at': created_at,
      'updated_at': updated_at
    };
  }
}

class CreateAvatarResponse implements JsonSerializable {
  final UserAvatar avatar;

  CreateAvatarResponse({required this.avatar});

  factory CreateAvatarResponse.fromJson(Map<String, dynamic> json) {
    return CreateAvatarResponse(avatar: UserAvatar.fromJson(json));
  }

  @override
  CreateAvatarResponse fromJson(Map<String, dynamic> json) {
    return CreateAvatarResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar.toJson(),
    };
  }
}

class GetAvatarResponse implements JsonSerializable {
  final UserAvatar avatar;

  GetAvatarResponse({required this.avatar});

  factory GetAvatarResponse.fromJson(Map<String, dynamic> json) {
    return GetAvatarResponse(avatar: UserAvatar.fromJson(json));
  }

  @override
  GetAvatarResponse fromJson(Map<String, dynamic> json) {
    return GetAvatarResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar.toJson(),
    };
  }
}

class UploadAvatarResponse implements JsonSerializable {
  final String url;

  UploadAvatarResponse({required this.url});

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) {
    return UploadAvatarResponse(url: json['url']);
  }

  @override
  UploadAvatarResponse fromJson(Map<String, dynamic> json) {
    return UploadAvatarResponse.fromJson(json);
  }
}
