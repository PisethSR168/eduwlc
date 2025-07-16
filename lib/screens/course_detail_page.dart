import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';
import 'package:eduwlc/models/subject.dart';

class CourseDetailPage extends StatelessWidget {
  final Subject subject;

  const CourseDetailPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          subject.name,
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kDarkGreyColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(Icons.code, color: kGreyColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Code: ${subject.code}',
                  style: TextStyle(fontSize: 18, color: kDarkGreyColor),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.business, color: kGreyColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Department: ${subject.department.name}',
                  style: TextStyle(fontSize: 18, color: kDarkGreyColor),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.star, color: kGreyColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Credit Hours: ${subject.creditHours}',
                  style: TextStyle(fontSize: 18, color: kDarkGreyColor),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'Description:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDarkGreyColor,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              subject.description,
              style: TextStyle(fontSize: 16, color: kGreyColor, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.info_outline, size: 40, color: kLightGreyColor),
                    const SizedBox(height: 8),
                    Text(
                      'More details about course offerings and exams can be added here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
