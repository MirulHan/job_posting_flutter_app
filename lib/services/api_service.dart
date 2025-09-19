import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/api_response_model.dart';

class ApiService extends GetConnect {
  static ApiService? _instance;

  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal();

  Future<ApiService> init() {
    httpClient.baseUrl = '${dotenv.env['API_BASE_URL']}/api';

    httpClient.timeout = const Duration(
      milliseconds: 30000,
    );

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      log('API Request: ${request.method} ${request.url}');
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      log('API Response: ${response.statusCode} - ${response.request?.url}');
      return response;
    });

    return Future.value(this);
  }

  Future<ApiResponseModel> getRequest(String endpoint) async {
    try {
      final response = await get(endpoint);
      return ApiResponseModel.fromResponse(response);
    } catch (e) {
      log('GET Error: $e');
      return ApiResponseModel.error(
        statusCode: 500,
        message: 'GET Error: $e',
      );
    }
  }

  Future<ApiResponseModel> postRequest(String endpoint, dynamic body) async {
    try {
      final response = await post(endpoint, body);
      return ApiResponseModel.fromResponse(response);
    } catch (e) {
      log('POST Error: $e');
      return ApiResponseModel.error(
        statusCode: 500,
        message: 'POST Error: $e',
      );
    }
  }

  Future<ApiResponseModel> putRequest(String endpoint, dynamic body) async {
    try {
      final response = await put(endpoint, body);
      return ApiResponseModel.fromResponse(response);
    } catch (e) {
      log('PUT Error: $e');
      return ApiResponseModel.error(
        statusCode: 500,
        message: 'PUT Error: $e',
      );
    }
  }

  Future<ApiResponseModel> deleteRequest(String endpoint) async {
    try {
      final response = await delete(endpoint);
      return ApiResponseModel.fromResponse(response);
    } catch (e) {
      log('DELETE Error: $e');
      return ApiResponseModel.error(
        statusCode: 500,
        message: 'DELETE Error: $e',
      );
    }
  }
}
