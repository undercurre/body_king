import '../../services/JSONSerializable.dart';

class Motto implements JsonSerializable {
  final String id;
  final String user_id;
  final String motto_text;
  final String created_at;
  final String updated_at;

  Motto(
      {required this.id,
      required this.user_id,
      required this.motto_text,
      required this.created_at,
      required this.updated_at});

  factory Motto.fromJson(Map<String, dynamic> json) {
    return Motto(
        id: json['id'],
        user_id: json['user_id'],
        motto_text: json['motto_text'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }

  @override
  Motto fromJson(Map<String, dynamic> json) {
    return Motto.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'motto_text': motto_text,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}

class CreateMottoResponse implements JsonSerializable {
  final Motto motto;

  CreateMottoResponse({required this.motto});

  factory CreateMottoResponse.fromJson(Map<String, dynamic> json) {
    return CreateMottoResponse(
      motto: Motto.fromJson(json),
    );
  }

  @override
  CreateMottoResponse fromJson(Map<String, dynamic> json) {
    return CreateMottoResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'motto': motto.toJson(),
    };
  }
}

class GetMottoByUserResponse implements JsonSerializable {
  final List<Motto> mottos;

  GetMottoByUserResponse({required this.mottos});

  factory GetMottoByUserResponse.fromJson(Map<String, dynamic> json) {
    return GetMottoByUserResponse(
      mottos: (json['result'] as List)
          .map((mottoJson) => Motto.fromJson(mottoJson))
          .toList(),
    );
  }

  @override
  GetMottoByUserResponse fromJson(Map<String, dynamic> json) {
    return GetMottoByUserResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'mottos': mottos.map((motto) => motto.toJson()).toList(),
    };
  }
}