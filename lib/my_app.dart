import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_theme.dart';

import 'features/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      home: const SplashScreen(),
    );
  }
}
