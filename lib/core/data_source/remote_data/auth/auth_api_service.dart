import 'package:dio/dio.dart';
import 'auth_dio_config.dart';

abstract class AuthBaseApiService{
  Future<dynamic> post({required String endPoint, Map<String, dynamic>? body , String? token});
  Future<dynamic> get({required String endPoint, Map<String, dynamic>? body});
}


class AuthApiService extends AuthBaseApiService{
  final Dio dio = AuthDioConfig.createDio();
  @override
  Future<dynamic> post({required String endPoint, Map<String, dynamic>? body, String? token}) async {
    if(token != null){
      dio.options.headers["Authorization"] = "Bearer $token";
    }

    try{
      final response = await dio.post(endPoint, data: body);

      if((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 301) < 300){
        return response.data as Map<String, dynamic>;
      }else{
        throw Exception(response.data["message"] ?? "Failed to Load Data");
      }
    }catch(_){
    throw Exception("Failed to Load Data");
    }
  }

  @override
  Future<dynamic> get({required String endPoint, Map<String, dynamic>? body}) async{
    try{
      final response = await dio.get(endPoint);

      if((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 301) < 300){
        return response.data as Map<String, dynamic>;
      }else{
        throw Exception(response.data["message"] ?? "Failed to Load Data");
      }
    }catch(_){
      throw Exception("Failed to Load Data");
    }
  }
}
