import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.settings_outlined,
              color: kDarkGreyColor,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kSecondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: kWhiteColor,
                    child: Icon(Icons.person, size: 50, color: kPrimaryColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Student ID: 2024001',
                    style: TextStyle(
                      color: kWhiteColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Courses', '12'),
                      _buildStatItem('Hours', '48'),
                      _buildStatItem('Certificates', '3'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items
            _buildMenuItem(
              icon: Icons.book_outlined,
              title: 'My Courses',
              subtitle: 'View enrolled courses',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.download_outlined,
              title: 'Downloads',
              subtitle: 'Offline content',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.favorite_outline,
              title: 'Favorites',
              subtitle: 'Saved courses',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.history,
              title: 'Learning History',
              subtitle: 'Track your progress',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.card_membership,
              title: 'Certificates',
              subtitle: 'Your achievements',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.payment_outlined,
              title: 'Payment History',
              subtitle: 'Transaction records',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get assistance',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'App information',
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Logout Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: kBookstoreColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kBookstoreColor),
              ),
              child: Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kBookstoreColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: kPrimaryColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: kGreyColor, fontSize: 12),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: kGreyColor, size: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: kLightGreyColor.withOpacity(0.5),
      ),
    );
  }
}
