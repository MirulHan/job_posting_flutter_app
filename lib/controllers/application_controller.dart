import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/api_response_model.dart';
import '../services/api_service.dart';

class ApplicationController extends GetxController {
  late final ApiService _apiService;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var fieldErrors = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<bool> submitApplication({
    required int jobPostId,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String workExperience,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      fieldErrors.clear();

      final Map<String, dynamic> applicationData = {
        'job_post_id': jobPostId,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'email': email,
        'work_experience': workExperience,
      };

      final ApiResponseModel response = await _apiService.postRequest(
        '/job-applications',
        applicationData,
      );

      if (response.isSuccess) {
        log('Application submitted successfully');
        return true;
      }

      if (response.data != null && response.data!['errors'] != null) {
        final errors = response.data!['errors'] as Map<String, dynamic>;

        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            fieldErrors[key] = value.first.toString();
          }
        });

        log('Validation errors: $fieldErrors');
        return false;
      }

      errorMessage.value = response.message.isNotEmpty
          ? response.message
          : 'Failed to submit application';

      _showErrorSnackbar(errorMessage.value);

      return false;
    } catch (e) {
      errorMessage.value = 'Error: $e';
      log('Error submitting application: $e');
      _showErrorSnackbar('Failed to submit application. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
      icon: const Icon(Icons.error, color: Colors.red),
      duration: const Duration(seconds: 4),
    );
  }

  String? getFieldError(String fieldName) {
    return fieldErrors[fieldName];
  }

  bool hasFieldError(String fieldName) {
    return fieldErrors.containsKey(fieldName);
  }

  void clearErrors() {
    errorMessage.value = '';
    fieldErrors.clear();
  }

  void clearFieldError(String fieldName) {
    fieldErrors.remove(fieldName);
  }
}
