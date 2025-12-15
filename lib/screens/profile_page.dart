import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';
import 'package:eduwlc/view/login_user.dart';
// IMPORTANT: Adjust this import path if your file location is different
import '../services/auth_service.dart';

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

        // FIX: Check for the nested 'user' key based on your successful login response
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
    // Optional: Show a progress indicator
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logging out...'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    // Call the logout API and clear local token
    await _authService.logout();

    // Navigate to the Login screen and clear the navigation stack
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
              // Offer a retry or re-login path
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

    // Safely extract data
    final String userName = _userData!['name'] ?? 'User Name N/A';
    final String userEmail = _userData!['email'] ?? 'N/A';
    final String studentId = _userData!['id']?.toString() ?? 'N/A';
    final String avatarUrl = _userData!['avatar_url'] ?? '';

    // FIX: Client-side replacement for Android Emulator IP (127.0.0.1 -> 10.0.2.2)
    final String displayAvatarUrl =
        avatarUrl.isNotEmpty
            ? avatarUrl.replaceFirst('127.0.0.1', '10.0.2.2')
            : '';

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
                    // Use the corrected image URL here
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
                    userName, // Display fetched name
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Email: $userEmail', // Display fetched email
                    style: TextStyle(
                      color: kWhiteColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // You might want to use real stats from the API here later
                      _buildStatItem('Courses', '12'),
                      _buildStatItem('Hours', '48'),
                      _buildStatItem('Certificates', '3'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items (Unchanged)
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
              onTap: _handleLogout, // Calls the API and clears local token
              child: Container(
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
            color: const Color.fromARGB(255, 75, 51, 212).withOpacity(0.1),
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
        tileColor: kLightGreyColor.withOpacity(0.5),
      ),
    );
  }
}
