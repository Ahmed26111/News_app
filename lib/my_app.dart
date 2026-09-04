import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'features/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
