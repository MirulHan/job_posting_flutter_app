import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/primary_layout.dart';
import '../controllers/theme_controller.dart';
import 'job_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return PrimaryLayoutHelper.withoutAppBar(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Job Posting App',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => Get.to(() => const JobListScreen()),
                  icon: const Icon(Icons.work),
                  label: const Text('View Available Jobs'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
          // Floating theme toggle button in top-right corner
          Positioned(
            top: 50,
            right: 20,
            child: Obx(() => FloatingActionButton(
                  onPressed: () => themeController.toggleTheme(),
                  mini: true,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.9),
                  child: Icon(
                    themeController.themeIcon,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
