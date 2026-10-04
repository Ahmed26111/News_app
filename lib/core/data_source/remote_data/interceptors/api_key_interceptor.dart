import 'package:dio/dio.dart';
import 'package:news_app/core/data_source/remote_data/news/news_api_configuration.dart';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['apiKey'] = NewsApiConfiguration.apiKey;
    handler.next(options);
  }
}