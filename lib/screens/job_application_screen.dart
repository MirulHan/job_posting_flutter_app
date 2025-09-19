import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/job.dart';
import '../controllers/theme_controller.dart';
import '../controllers/application_controller.dart';
import '../widgets/primary_layout.dart';
import 'job_list_screen.dart';

class JobApplicationScreen extends StatefulWidget {
  final Job job;

  const JobApplicationScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final ApplicationController applicationController =
        Get.put(ApplicationController());

    return PrimaryLayoutHelper.withTitle(
      title: 'Apply for Position',
      actions: [
        Obx(() => IconButton(
              onPressed: () => themeController.toggleTheme(),
              icon: Icon(themeController.themeIcon),
              tooltip: themeController.themeText,
            )),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Position Details',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.job.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.job.company,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.blue[600],
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.job.location,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Application Form',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => TextFormField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('full_name')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('full_name')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              errorText: applicationController
                                  .getFieldError('full_name'),
                            ),
                            onChanged: (value) {
                              if (applicationController
                                  .hasFieldError('full_name')) {
                                applicationController
                                    .clearFieldError('full_name');
                              }
                            },
                            textInputAction: TextInputAction.next,
                          )),
                      const SizedBox(height: 16),
                      Obx(() => TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter your phone number',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('phone_number')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('phone_number')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              errorText: applicationController
                                  .getFieldError('phone_number'),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              if (applicationController
                                  .hasFieldError('phone_number')) {
                                applicationController
                                    .clearFieldError('phone_number');
                              }
                            },
                            textInputAction: TextInputAction.next,
                          )),
                      const SizedBox(height: 16),
                      Obx(() => TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your email address',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('email')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('email')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              errorText:
                                  applicationController.getFieldError('email'),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // Clear error when user starts typing
                              if (applicationController
                                  .hasFieldError('email')) {
                                applicationController.clearFieldError('email');
                              }
                            },
                            textInputAction: TextInputAction.next,
                          )),
                      const SizedBox(height: 16),
                      Obx(() => TextFormField(
                            controller: _experienceController,
                            decoration: InputDecoration(
                              labelText: 'Work Experience',
                              hintText:
                                  'Describe your relevant work experience',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0, left: 12.0, right: 8.0),
                                child: Icon(Icons.work),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('work_experience')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: applicationController
                                          .hasFieldError('work_experience')
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              alignLabelWithHint: true,
                              errorText: applicationController
                                  .getFieldError('work_experience'),
                            ),
                            maxLines: 5,
                            onChanged: (value) {
                              if (applicationController
                                  .hasFieldError('work_experience')) {
                                applicationController
                                    .clearFieldError('work_experience');
                              }
                            },
                            textInputAction: TextInputAction.done,
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: applicationController.isLoading.value
                          ? null
                          : () => _submitApplication(applicationController),
                      icon: applicationController.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.send),
                      label: Text(
                        applicationController.isLoading.value
                            ? 'Submitting...'
                            : 'Submit Application',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _submitApplication(ApplicationController controller) async {
    controller.clearErrors();

    final success = await controller.submitApplication(
      jobPostId: widget.job.id,
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      workExperience: _experienceController.text.trim(),
    );

    if (success) {
      Get.snackbar(
        'Success!',
        'Your application has been submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        icon: const Icon(Icons.check_circle, color: Colors.green),
        duration: const Duration(seconds: 3),
      );

      Get.off(() => const JobListScreen());
    }
  }
}
