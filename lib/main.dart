import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';
import 'core/data_source/local_data/user_repository.dart';
import 'core/data_source/local_data/bookmark_repository.dart';
import 'core/data_source/remote_data/dio_example.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  await ScreenUtil.ensureScreenSize();
  await UserRepository().init();
  await BookmarkRepository().init();
  DioExample.exampleGetRequest();
  DioExample.exampleGetRequestWithQueryParameter();
  DioExample.examplePostRequest();
  DioExample.examplePutRequest();
  DioExample.exampleDeleteRequest();
  DioExample.exampleErrorHandling();
  runApp(const MyApp());
}