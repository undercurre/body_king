import 'JSONSerializable.dart';

class ApiResponse<T extends JsonSerializable> {
  final int code;
  final T data;
  final String msg;

  ApiResponse({required this.code, required this.data, required this.msg});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      code: json['code'],
      data: fromJsonT(json['data']),
      msg: json['msg'],
    );
  }
}
