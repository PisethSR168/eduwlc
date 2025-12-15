import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';
import 'package:eduwlc/view/login_user.dart';
import '../services/auth_service.dart'; // Ensure this path is correct

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });

    final data = await _authService.getProfile();

    if (mounted) {
      setState(() {
        _isLoading = false;

        // Check for the nested 'user' key based on your successful login response
        if (data != null && data.containsKey('user')) {
          _userData = data['user'];
        }
        // Fallback: If the API returns the user object directly (unwrapped)
        else if (data != null &&
            (data.containsKey('name') || data.containsKey('email'))) {
          _userData = data;
        } else {
          _userData = null;
        }
      });
    }
  }

  Future<void> _handleLogout() async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logging out...'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    await _authService.logout();

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginUser()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: kWhiteColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_userData == null) {
      return Scaffold(
        // ... (Error UI remains the same)
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0,
          title: const Text(
            'My Profile',
            style: TextStyle(color: kDarkGreyColor),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Failed to load profile data.',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchProfile,
                child: const Text('Retry Load'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _handleLogout,
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }

    // Safely extract data for display
    final String userName = _userData!['name'] ?? 'User Name N/A';
    final String userEmail = _userData!['email'] ?? 'N/A';
    final String studentId = _userData!['id']?.toString() ?? 'N/A';
    final String avatarUrl = _userData!['avatar_url'] ?? '';

    // --- NEW: Extracting dynamic stat data ---
    // Use .toString() to ensure it's a string, and '0' as a safe fallback
    final String coursesCount = _userData!['courses_count']?.toString() ?? '0';
    final String hoursCount = _userData!['hours_completed']?.toString() ?? '0';
    final String certificatesCount =
        _userData!['certificates_count']?.toString() ?? '0';

    // Client-side replacement for Android Emulator IP (127.0.0.1 -> 10.0.2.2)
    final String displayAvatarUrl =
        avatarUrl.isNotEmpty
            ? avatarUrl.replaceFirst('127.0.0.1', '10.0.2.2')
            : '';

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        // ... (App Bar remains the same)
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
                  colors: [
                    const Color.fromARGB(255, 75, 51, 212),
                    const Color.fromARGB(255, 99, 78, 255),
                  ],
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
                    backgroundImage:
                        displayAvatarUrl.isNotEmpty
                            ? NetworkImage(displayAvatarUrl)
                            : null,
                    child:
                        displayAvatarUrl.isEmpty
                            ? Icon(
                              Icons.person,
                              size: 50,
                              color: const Color.fromARGB(255, 75, 51, 212),
                            )
                            : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Email: $userEmail',
                    style: TextStyle(
                      color: kWhiteColor.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student ID: $studentId',
                    style: TextStyle(
                      color: kWhiteColor.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // --- UPDATED STATS ---
                      _buildStatItem('Courses', coursesCount),
                      _buildStatItem('Hours', hoursCount),
                      _buildStatItem('Certificates', certificatesCount),
                      // --- END UPDATED STATS ---
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items (Unchanged)
            // ... (rest of the _buildMenuItem widgets)
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
            GestureDetector(
              onTap: _handleLogout,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: kBookstoreColor.withValues(alpha: 0.1),
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
            ),
          ],
        ),
      ),
    );
  }

  // Helper method definitions remain the same
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
          style: TextStyle(
            color: kWhiteColor.withValues(alpha: 0.8),
            fontSize: 12,
          ),
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
            color: const Color.fromARGB(
              255,
              75,
              51,
              212,
            ).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color.fromARGB(255, 75, 51, 212),
            size: 24,
          ),
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
        tileColor: kLightGreyColor.withValues(alpha: 0.5),
      ),
    );
  }
}
