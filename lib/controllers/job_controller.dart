import 'dart:developer';
import 'package:get/get.dart';
import '../models/job.dart';
import '../models/api_response_model.dart';
import '../services/api_service.dart';

class JobController extends GetxController {
  late final ApiService _apiService;

  var jobs = <Job>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final ApiResponseModel response =
          await _apiService.getRequest('/job-posts');

      if (response.isSuccess && response.data != null) {
        final List<dynamic> jobList = response.data!['data'] as List<dynamic>;

        jobs.value = jobList
            .map((json) => Job.fromJson(json as Map<String, dynamic>))
            .toList();

        return;
      }

      errorMessage.value = 'Failed to fetch jobs: ${response.message}';
    } catch (e) {
      errorMessage.value = 'Error: $e';
      log('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Job?> fetchJob(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final ApiResponseModel response =
          await _apiService.getRequest('/job-posts/$id');

      if (response.isSuccess && response.data != null) {
        // For single job, the data might be directly in response.data or nested under 'data' key
        final jobData = response.data!.containsKey('data')
            ? response.data!['data']
            : response.data!;
        return Job.fromJson(jobData as Map<String, dynamic>);
      } else {
        errorMessage.value = 'Failed to fetch job: ${response.message}';
        return null;
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      log('Error fetching job: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshJobs() async {
    await fetchJobs();
  }

  List<Job> get activeJobs {
    return jobs.where((job) => job.isActive).toList();
  }
}
