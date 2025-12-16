import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';
import 'package:eduwlc/view/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_user.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  Widget _buildSplashUI(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 300,
                ),
                child: Image.asset(ksplashlogoAssetsPath, fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              Text(kAppName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 50),
              if (authProvider.isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return _buildSplashUI(context);
    } else {
      return authProvider.isAuthenticated
          ? const MainNavigation()
          : const LoginUser();
    }
  }
}
