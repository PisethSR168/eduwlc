import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userData = authProvider.userData;

    List<SubjectScore> dynamicScores = [];
    if (userData != null && userData['enrollments'] != null) {
      final List<dynamic> enrollmentList = userData['enrollments'];
      dynamicScores =
          enrollmentList
              .map(
                (e) => SubjectScore.fromEnrollment(e as Map<String, dynamic>),
              )
              .toList();
    }

    return Scaffold(
      backgroundColor: kLightGreyColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text(
          'Academic Scores',
          style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor.withValues(alpha: 0.1), kLightGreyColor],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 24),

              ...dynamicScores.map((score) => _buildSubjectScoreCard(score)),

              const SizedBox(height: 16),
              _buildGPACard(dynamicScores),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor, kSecondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.school_outlined, color: kWhiteColor, size: 40),
          const SizedBox(height: 12),
          const Text(
            'Academic Performance',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Detailed subject-wise grade breakdown',
            style: TextStyle(
              color: kWhiteColor.withValues(alpha: 0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectScoreCard(SubjectScore score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.book, color: kPrimaryColor, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    score.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
                _buildGradeBadge(score.grade),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildScoreRow("Attendance Grade", score.attendance),
                _buildScoreRow("Listening Grade", score.listening),
                _buildScoreRow("Writing Grade", score.writing),
                _buildScoreRow("Reading Grade", score.reading),
                _buildScoreRow("Speaking Grade", score.speaking),
                _buildScoreRow("Midterm Grade", score.midterm),
                _buildScoreRow("Final Exam Grade", score.finalScore),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                _buildScoreRow("TOTAL SCORE", score.total, isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? kDarkGreyColor : kGreyColor,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? kPrimaryColor : kDarkGreyColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeBadge(String grade) {
    Color color = _getGradeColor(grade);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        grade,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildGPACard(List<SubjectScore> scores) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4A5FBF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Overall Average: ${_calculateAverage(scores)}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kWhiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _calculateAverage(List<SubjectScore> scores) {
    if (scores.isEmpty) return "0.0";
    double total = scores.fold(
      0,
      (sum, item) => sum + double.parse(item.total),
    );
    return (total / scores.length).toStringAsFixed(2);
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B+':
        return Colors.blue;
      case 'B':
        return Colors.orange;
      case 'C+':
        return Colors.amber;
      case 'C':
        return Colors.deepOrange;
      default:
        return kGreyColor;
    }
  }
}

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
