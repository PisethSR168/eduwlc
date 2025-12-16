import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';
import 'package:eduwlc/screens/auth/login_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userData = authProvider.userData;

    if (authProvider.isLoading && userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userData == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => authProvider.fetchUserProfile(),
            child: const Text('Retry Load Profile'),
          ),
        ),
      );
    }

    final String userName = userData['name'] ?? 'User Name N/A';
    final String userEmail = userData['email'] ?? 'N/A';
    final String studentId = userData['id']?.toString() ?? 'N/A';
    final String avatarUrl = userData['avatar_url'] ?? '';

    final String coursesCount = userData['courses_count']?.toString() ?? '0';
    final String hoursCount = userData['hours_completed']?.toString() ?? '0';
    final String certificatesCount =
        userData['certificates_count']?.toString() ?? '0';

    final String displayAvatarUrl =
        avatarUrl.isNotEmpty
            ? avatarUrl.replaceFirst('127.0.0.1', '10.0.2.2')
            : '';

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(backgroundColor: kWhiteColor, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4B33D4), Color(0xFF634EFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildAvatar(displayAvatarUrl),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Email: $userEmail',
                    style: TextStyle(
                      color: kWhiteColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student ID: $studentId',
                    style: TextStyle(
                      color: kWhiteColor.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Courses', coursesCount),
                      _buildStatItem('Hours', hoursCount),
                      _buildStatItem('Certificates', certificatesCount),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildMenuItem(
              icon: Icons.book_outlined,
              title: 'My Courses',
              subtitle: 'View enrolled courses',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.card_membership,
              title: 'Certificates',
              subtitle: 'Your achievements',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'App information',
              onTap: () {},
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                await authProvider.logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginUser()),
                    (route) => false,
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: kBookstoreColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kBookstoreColor),
                ),
                child: const Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kBookstoreColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kWhiteColor,
      ),
      child:
          url.isNotEmpty
              ? ClipOval(child: Image.network(url, fit: BoxFit.cover))
              : const Icon(Icons.person, size: 50, color: Color(0xFF4B33D4)),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: kWhiteColor.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF4B33D4)),
      title: Text(
        title,
        style: const TextStyle(
          color: kDarkGreyColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
