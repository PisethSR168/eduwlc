class Course {
  final int id;
  final String title;
  final String? code;
  final String? description;

  Course({required this.id, required this.title, this.code, this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    final courseData = json['course'] ?? json;
    return Course(
      id: courseData['id'] as int,
      title: courseData['title'] ?? courseData['name'] ?? 'Untitled Course',
      code: courseData['code'],
      description: courseData['description'],
    );
  }
}
