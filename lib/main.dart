import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  // SharedPreferencesManager().clear();
  runApp(const MyApp());
}