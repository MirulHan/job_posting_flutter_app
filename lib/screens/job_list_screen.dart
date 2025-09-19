import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/job.dart';
import '../widgets/primary_layout.dart';
import 'job_detail_screen.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobController jobController = Get.put(JobController());
    final ThemeController themeController = Get.find<ThemeController>();

    return PrimaryLayoutHelper.withTitle(
      title: 'Available Jobs',
      actions: [
        Obx(() => IconButton(
              onPressed: () => themeController.toggleTheme(),
              icon: Icon(themeController.themeIcon),
              tooltip: themeController.themeText,
            )),
      ],
      body: Obx(() {
        if (jobController.isLoading.value && jobController.jobs.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (jobController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    jobController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => jobController.refreshJobs(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (jobController.jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.work_off,
                  size: 64,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Jobs Available',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for new opportunities',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => jobController.refreshJobs(),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => jobController.refreshJobs(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobController.activeJobs.length,
            itemBuilder: (context, index) {
              final job = jobController.activeJobs[index];
              return JobCard(
                job: job,
                onTap: () => Get.to(() => JobDetailScreen(job: job)),
              );
            },
          ),
        );
      }),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.blue[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      job.jobType,
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.location,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    job.formattedSalary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.green[600],
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Description (truncated)
              Text(
                job.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Skills
              if (job.skills.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: job.skills
                      .take(3)
                      .map((skill) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],

              // Deadline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color:
                            Theme.of(context).iconTheme.color?.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Deadline: ${job.formattedDeadline}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
