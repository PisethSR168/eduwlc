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

  final String defaultUsername = 'user';
  final String defaultPassword = '1234';

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
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Image.asset('assets/wlc_logo.png', width: 120, height: 120),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                prefix: Icon(Icons.account_circle),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefix: Icon(Icons.lock),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
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
