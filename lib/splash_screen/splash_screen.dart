import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'splash_screen_2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await AuthService.ensureDefaultAccount();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    final loggedIn = await AuthService.isLoggedIn();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            loggedIn ? const HomePage() : const SplashScreen2(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF399195),
              Color(0xFF1E4C4E),
              Color(0xFF122E2F),
            ],
            stops: [0.0, 0.72, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Image.asset(
              'assets/images/logo_1.png',
              width: 230,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
