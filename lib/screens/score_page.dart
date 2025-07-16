import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Academic Scores',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(Icons.analytics_outlined, color: kWhiteColor, size: 24),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor.withOpacity(0.1), kLightGreyColor],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
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
                      color: kPrimaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.school, color: kWhiteColor, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      'Academic Performance',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Track your progress across all terms',
                      style: TextStyle(
                        color: kWhiteColor.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Term 1
              _buildTermCard('ឆ្នាំទី 1 ឆមាស 1(Term:1)', [
                SubjectScore('Art of Living', 52.0, 33.0, 85.0, 'A'),
                SubjectScore(
                  'Computer for Office Application',
                  53.0,
                  23.0,
                  76.0,
                  'B',
                ),
                SubjectScore('Core English I', 51.0, 33.0, 84.0, 'B+'),
                SubjectScore('Critical Thinking', 49.0, 28.0, 77.0, 'B'),
                SubjectScore(
                  'Introduction to Economics',
                  50.0,
                  34.0,
                  84.0,
                  'B+',
                ),
              ]),
              const SizedBox(height: 16),

              // Term 2
              _buildTermCard('ឆ្នាំទី 1 ឆមាស 2(Term:2)', [
                SubjectScore('Net Programming I', 51.0, 34.0, 85.0, 'A'),
                SubjectScore(
                  'Fundamental of Computer Technology',
                  55.0,
                  36.0,
                  91.0,
                  'A',
                ),
                SubjectScore('Graphic Design', 45.0, 30.0, 75.0, 'B'),
                SubjectScore(
                  'Mathematics for Computing',
                  56.0,
                  26.0,
                  82.0,
                  'B+',
                ),
                SubjectScore('Programming Methodology', 55.0, 34.0, 89.0, 'A'),
              ]),
              const SizedBox(height: 16),

              // Term 3
              _buildTermCard('ឆ្នាំទី 2 ឆមាស 1(Term:3)', []),
              const SizedBox(height: 16),

              // Total GPA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A5FBF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total GPA 3.63',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermCard(String termTitle, List<SubjectScore> subjects) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Term Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColor.withOpacity(0.1),
                  kSecondaryColor.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: kWhiteColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  termTitle,
                  style: TextStyle(
                    color: kDarkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Subjects Table - only if there are subjects
          if (subjects.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: kLightGreyColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Subject Name',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Midterm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Final',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Total',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Grade',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subject Rows
                  ...subjects
                      .map((subject) => _buildSubjectRow(subject))
                      .toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(SubjectScore subject) {
    Color gradeColor = _getGradeColor(subject.grade);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kLightGreyColor, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              subject.name,
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              subject.midterm.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: kDarkGreyColor, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              subject.finalScore.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: kDarkGreyColor, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              subject.total.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: kDarkGreyColor, fontSize: 12),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: gradeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gradeColor, width: 1),
              ),
              child: Text(
                subject.grade,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: gradeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return const Color(0xFF4CAF50); // Green
      case 'B+':
        return const Color(0xFF2196F3); // Blue
      case 'B':
        return const Color(0xFFFF9800); // Orange
      case 'C+':
        return const Color(0xFFFFC107); // Amber
      case 'C':
        return const Color(0xFFFF5722); // Deep Orange
      default:
        return kGreyColor;
    }
  }
}

class SubjectScore {
  final String name;
  final double midterm;
  final double finalScore;
  final double total;
  final String grade;

  SubjectScore(
    this.name,
    this.midterm,
    this.finalScore,
    this.total,
    this.grade,
  );
}
