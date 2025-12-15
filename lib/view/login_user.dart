import 'main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Replaced Future<bool> with Future<void> as AuthService returns a Map now
  Future<void> _attemptLogin() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true; // Start loading
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Basic client-side validation
    if (username.isEmpty || password.isEmpty) {
      _showSnackBar('Please enter both username and password.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final authService = AuthService();
    // CALL: Receive the result from the service
    final result = await authService.login(username, password);

    if (mounted) {
      setState(() {
        _isLoading = false; // Stop loading
      });

      // CHECK: Use the result boolean
      if (result) {
        // Successful login: Navigate to the main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      } else {
        // Failed login: Show error message
        _showSnackBar(
          'Login failed. Please check your credentials and try again.',
        );
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 227, 42),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Image.asset('assets/wlc_logo.png', width: 120, height: 120),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavigation(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
