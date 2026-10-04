import 'package:dio/dio.dart';

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
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {}
}