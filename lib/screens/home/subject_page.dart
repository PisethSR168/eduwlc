import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';
import 'package:eduwlc/screens/home/subject_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kLightGreyColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Academic Subjects',
          style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: kWhiteColor),
            onPressed: () => authProvider.fetchSubjects(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor.withValues(alpha: 0.1), kLightGreyColor],
          ),
        ),
        child: _buildBody(context, authProvider),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AuthProvider authProvider) {
    if (authProvider.isLoading && authProvider.subjects.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () => authProvider.fetchSubjects(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
                  color: kPrimaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.library_books, color: kWhiteColor, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Subject Overview',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Manage your ${authProvider.subjects.length} registered subjects',
                  style: TextStyle(
                    color: kWhiteColor.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ...authProvider.subjects.map(
            (subject) => _buildSubjectCard(context, subject),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, dynamic subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.book_outlined, color: kPrimaryColor),
        ),
        title: Text(
          subject.name,
          style: TextStyle(
            color: kDarkGreyColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Code: ${subject.code} • Credits: ${subject.creditHours}',
        ),
        trailing: Icon(Icons.chevron_right, color: kGreyColor),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectDetailPage(subject: subject),
            ),
          );
        },
      ),
    );
  }
}
