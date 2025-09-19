import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'core/app.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  final apiService = ApiService.instance;
  await apiService.init();
  Get.put<ApiService>(apiService, permanent: true);
}
