import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../controllers/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          title: 'Job Posting App',
          theme: _lightTheme(),
          darkTheme: _darkTheme(),
          themeMode: themeController.themeMode.value,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
        bodySmall: TextStyle(color: Colors.black54),
        headlineLarge:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        headlineMedium:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        headlineSmall:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        titleLarge:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        titleMedium:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        titleSmall:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 2,
      ),
    );
  }

  // Dark theme configuration with white text
  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F), // Dark app bar
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white70),
        headlineLarge:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        headlineMedium:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        headlineSmall:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        titleMedium:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          elevation: 3,
        ),
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF1E1E1E),
        elevation: 3,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
        surface: Color(0xFF1E1E1E),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
    );
  }
}
