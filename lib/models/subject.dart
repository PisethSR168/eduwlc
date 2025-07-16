import 'package:eduwlc/models/department.dart';

class Subject {
  final int id;
  final String name;
  final String code;
  final int departmentId;
  final Department department;
  final String description;
  final int creditHours;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.departmentId,
    required this.department,
    required this.description,
    required this.creditHours,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      departmentId: json['department_id'],
      department: Department.fromJson(json['department']),
      description: json['description'],
      creditHours: json['credit_hours'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }
}
