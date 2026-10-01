import 'dart:developer';

import 'package:news_app/core/data_source/remote_data/api_service.dart';

import '../../../core/data_source/remote_data/api_configuration.dart';

class AuthRepository{
  const AuthRepository({required this.apiService});

  final BaseApiService apiService;

  Future<void> login({required String username , required String password})async{
    try{
      final data = await apiService.post(baseUrl: ApiConfiguration.dummyBaseUrl, endPoint: ApiConfiguration.loginEndPoint, body: {
        "username": "emilys",
        "password": "emilyspass"
      });

      log(data.toString());
    }catch(e){
      log(e.toString());
    }
  }
}