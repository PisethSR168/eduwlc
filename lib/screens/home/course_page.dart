import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduwlc/providers/auth_provider.dart';
import 'package:eduwlc/constants/constant.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final courses = authProvider.myCourses;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          'My Enrolled Courses',
          style: TextStyle(fontWeight: FontWeight.bold, color: kDarkGreyColor),
        ),
        backgroundColor: kWhiteColor,
        elevation: 0,
      ),
      body:
          courses.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return _buildCourseCard(course);
                },
              ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 80,
            color: kGreyColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'You are not enrolled in any courses yet.',
            style: TextStyle(color: kGreyColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(dynamic course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF4B33D4).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.class_, color: Color(0xFF4B33D4)),
        ),
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          course.code ?? 'No Code',
          style: const TextStyle(color: kGreyColor),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: kGreyColor,
        ),
        onTap: () {},
      ),
    );
  }
}
