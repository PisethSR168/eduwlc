import 'package:flutter/material.dart';
import 'package:eduwlc/constants/constant.dart';

class EnrollmentPage extends StatelessWidget {
  final dynamic apiResponse;

  const EnrollmentPage({super.key, required this.apiResponse});

  @override
  Widget build(BuildContext context) {
    final List enrollments = apiResponse['enrollments'] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text(
          "My Enrollments",
          style: TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body:
          enrollments.isEmpty
              ? const Center(child: Text("No enrollments found"))
              : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: enrollments.length,
                itemBuilder: (context, index) {
                  final item = enrollments[index];
                  final offering = item['course_offering'] ?? {};
                  final subject = offering['subject'] ?? {};
                  final teacher = offering['teacher'] ?? {};

                  return _buildEnrollmentCard(
                    subject,
                    teacher,
                    offering,
                    item['status'],
                  );
                },
              ),
    );
  }

  Widget _buildEnrollmentCard(
    dynamic subject,
    dynamic teacher,
    dynamic offering,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject['code'] ?? '',
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusBadge(status),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              subject['name'] ?? 'Unknown Course',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            _buildIconInfo(
              Icons.person,
              "Teacher: ${teacher['name'] ?? 'N/A'}",
            ),
            const SizedBox(height: 10),
            _buildIconInfo(
              Icons.calendar_month,
              "Schedule: ${offering['schedule']} (${offering['time_slot']})",
            ),
            const SizedBox(height: 10),
            _buildIconInfo(Icons.payments, "Fee: \$${offering['fee']}"),
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: kGreyColor),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: kDarkGreyColor)),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    bool isStudying = status.toLowerCase() == 'studying';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:
            isStudying
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: isStudying ? Colors.green : Colors.orange,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
