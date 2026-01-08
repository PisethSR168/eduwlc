class SubjectScore {
  final String name;
  final String attendance;
  final String listening;
  final String writing;
  final String reading;
  final String speaking;
  final String midterm;
  final String finalScore;
  final String total;
  final String grade;

  SubjectScore({
    required this.name,
    required this.attendance,
    required this.listening,
    required this.writing,
    required this.reading,
    required this.speaking,
    required this.midterm,
    required this.finalScore,
    required this.total,
    required this.grade,
  });

  factory SubjectScore.fromEnrollment(Map<String, dynamic> json) {
    String f(dynamic v) => (v == null || v == "null") ? "0" : v.toString();

    double att = double.tryParse(f(json['attendance_grade'])) ?? 0;
    double lis = double.tryParse(f(json['listening_grade'])) ?? 0;
    double wri = double.tryParse(f(json['writing_grade'])) ?? 0;
    double rea = double.tryParse(f(json['reading_grade'])) ?? 0;
    double spe = double.tryParse(f(json['speaking_grade'])) ?? 0;
    double mid = double.tryParse(f(json['midterm_grade'])) ?? 0;
    double fin = double.tryParse(f(json['final_grade'])) ?? 0;

    double totalSum = att + lis + wri + rea + spe + mid + fin;

    return SubjectScore(
      name: json['course_offering']?['subject']?['name'] ?? "Unknown Subject",
      attendance: f(json['attendance_grade']),
      listening: f(json['listening_grade']),
      writing: f(json['writing_grade']),
      reading: f(json['reading_grade']),
      speaking: f(json['speaking_grade']),
      midterm: f(json['midterm_grade']),
      finalScore: f(json['final_grade']),
      total: totalSum.toStringAsFixed(1),
      grade: _calculateGrade(totalSum),
    );
  }

  static String _calculateGrade(double score) {
    if (score >= 85) return "A";
    if (score >= 75) return "B+";
    if (score >= 65) return "B";
    if (score >= 50) return "C";
    return "F";
  }
}
