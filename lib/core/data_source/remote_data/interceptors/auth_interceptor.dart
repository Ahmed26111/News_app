import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/bookmark_cubit.dart';
import 'package:news_app/core/data_source/local_data/bookmark_repository.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_keys.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';

import '../../../../features/authentication/login_screen.dart';
import '../../../../main.dart';
import '../../local_data/user_repository.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getCurrentUser()?.accessToken;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //? UnAuthorized
      final BuildContext context = navigationKey.currentContext!;

      UserRepository().removeCurrentUser();
      await BookmarkRepository().clearBookmarks();
      try {
        context.read<BookmarkCubit>().clearBookmarks();
      } catch (_) {}
      SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Session Expire, Please Login Again")));
    }

    handler.next(err);
  }
}