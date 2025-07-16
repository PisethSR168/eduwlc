import 'package:flutter/material.dart';
import 'package:eduwlc/screens/course_detail_page.dart';
import 'package:eduwlc/constant.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          'Subjects',
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.subject, size: 80, color: kPrimaryColor),
            const SizedBox(height: 16),
            Text(
              'Subjects Page',
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Browse all available subjects',
              style: TextStyle(color: kGreyColor, fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseDetailPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: kWhiteColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('View Course Details'),
            ),
          ],
        ),
      ),
    );
  }
}
