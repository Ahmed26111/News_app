import 'package:dio/dio.dart';
import 'package:news_app/core/data_source/remote_data/auth/auth_api_configuration.dart';

import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

class AuthDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AuthApiConfiguration.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      ),
    );

    dio.interceptors.addAll([AuthInterceptor() , LoggingInterceptor()]);

    return dio;
  }
}