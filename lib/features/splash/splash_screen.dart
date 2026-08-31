import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/data_source/local_data/shared_preferences_manager.dart';
import '../authentication/login_screen.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer timer = Timer(Duration(seconds: 2), () {
      final bool isOnBoardingCompleted =
          SharedPreferencesManager().getBool(
            SharedPreferencesKeys.onBoardingCompleted,
          ) ??
          false;
      final bool isLoginCompleted =
          SharedPreferencesManager().getBool(
            SharedPreferencesKeys.loginCompleted,
          ) ??
          false;

      if (!isOnBoardingCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } else if (!isLoginCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/splash_screen.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
