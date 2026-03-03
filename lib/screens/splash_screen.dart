import 'package:m_scms/constants/constant.dart';
import 'package:m_scms/providers/auth_provider.dart';
import 'package:m_scms/screens/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _hasNavigated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuth();
  }

  void _checkAuth() {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isLoading && !_hasNavigated) {
      _hasNavigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (_) =>
                    authProvider.isAuthenticated
                        ? const MainNavigation()
                        : const LoginScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // We still observe authProvider to show the loading indicator if needed,
    // but the navigation logic is moved to _checkAuth/didChangeDependencies.
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBackgroundColor, Color(0xFFF0F2F5)],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      ksplashlogoAssetsPath,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "WDUWLC",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child:
                    authProvider.isLoading
                        ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              kPrimaryColor,
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
