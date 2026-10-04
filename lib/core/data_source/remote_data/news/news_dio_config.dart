import 'package:dio/dio.dart';
import 'package:news_app/core/data_source/remote_data/interceptors/api_key_interceptor.dart';
import 'package:news_app/core/data_source/remote_data/news/news_api_configuration.dart';

import '../interceptors/logging_interceptor.dart';


class NewsDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: NewsApiConfiguration.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      ),
    );

    dio.interceptors.addAll([ApiKeyInterceptor() , LoggingInterceptor()]);

    return dio;
  }
}