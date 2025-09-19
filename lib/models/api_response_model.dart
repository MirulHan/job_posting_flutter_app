import 'package:get/get.dart';

class ApiResponseModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final Map<String, dynamic>? data;

  ApiResponseModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    this.data,
  });

  factory ApiResponseModel.fromResponse(Response response) {
    final body = response.body;
    
    return ApiResponseModel(
      statusCode: response.statusCode ?? 0,
      isSuccess: response.isOk,
      message: response.statusText ?? '',
      data: body is Map<String, dynamic> ? body : null,
    );
  }

  factory ApiResponseModel.error({
    required int statusCode,
    required String message,
  }) {
    return ApiResponseModel(
      statusCode: statusCode,
      isSuccess: false,
      message: message,
    );
  }

  // Helper methods
  T? getDataAs<T>() {
    if (data != null) {
      return data as T?;
    }
    return null;
  }

  @override
  String toString() {
    return 'ApiResponseModel{statusCode: $statusCode, isSuccess: $isSuccess, message: $message, data: $data}';
  }
}
