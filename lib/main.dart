import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';
import 'core/data_source/local_data/user_repository.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  await ScreenUtil.ensureScreenSize();
  await UserRepository().init();
  // SharedPreferencesManager().clear();
  runApp(const MyApp());
}