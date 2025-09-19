import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable theme mode
  var themeMode = ThemeMode.dark.obs;
  
  // Toggle between light and dark theme
  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark 
        ? ThemeMode.light 
        : ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
  }
  
  // Set specific theme
  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(themeMode.value);
  }
  
  // Check if current theme is dark
  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  
  // Get theme icon
  IconData get themeIcon => isDarkMode ? Icons.light_mode : Icons.dark_mode;
  
  // Get theme text
  String get themeText => isDarkMode ? 'Light Mode' : 'Dark Mode';
}
