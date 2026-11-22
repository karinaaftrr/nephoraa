import 'package:flutter/material.dart';
import 'FiturHD/dashboard.dart';
import 'splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF399195);
  static const Color secondaryColor = Color(0xFF1E4C4E);
  static const Color darkColor = Color(0xFF122E2F);
  static const Color backgroundColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nephora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          onSurface: darkColor,
          surface: backgroundColor,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            color: darkColor,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: darkColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: darkColor,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}
