import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final subjects = authProvider.subjects;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          'Subjects',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => authProvider.fetchSubjects(),
          ),
        ],
      ),
      body: _buildBody(context, authProvider),
    );
  }

  Widget _buildBody(BuildContext context, AuthProvider authProvider) {
    if (authProvider.isLoading && authProvider.subjects.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (authProvider.subjects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No subjects found.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => authProvider.fetchSubjects(),
              child: const Text('Fetch Subjects'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => authProvider.fetchSubjects(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: authProvider.subjects.length,
        itemBuilder: (context, index) {
          final subject = authProvider.subjects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                subject.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Code: ${subject.code}'),
                  Text('Credit Hours: ${subject.creditHours}'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
