class Job {
  final int id;
  final String title;
  final String description;
  final String company;
  final String location;
  final String jobType;
  final String salary;
  final String contactEmail;
  final List<String> skills;
  final String applicationDeadline;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.contactEmail,
    required this.skills,
    required this.applicationDeadline,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      jobType: json['job_type'] ?? '',
      salary: json['salary'] ?? '0.00',
      contactEmail: json['contact_email'] ?? '',
      skills: json['skills'] != null 
          ? List<String>.from(json['skills'])
          : <String>[],
      applicationDeadline: json['application_deadline'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'company': company,
      'location': location,
      'job_type': jobType,
      'salary': salary,
      'contact_email': contactEmail,
      'skills': skills,
      'application_deadline': applicationDeadline,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String get formattedSalary {
    final salaryValue = double.tryParse(salary) ?? 0.0;
    return '\$${salaryValue.toStringAsFixed(0)}';
  }

  String get formattedDeadline {
    try {
      final deadline = DateTime.parse(applicationDeadline);
      return '${deadline.day}/${deadline.month}/${deadline.year}';
    } catch (e) {
      return applicationDeadline;
    }
  }

  @override
  String toString() {
    return 'Job{id: $id, title: $title, company: $company, location: $location}';
  }
}
