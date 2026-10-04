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
    }
    on DioException catch(e){
      _handleDioException(e);
    }
    catch(_){
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
    }
    on DioException catch(e){
      _handleDioException(e);
    }
    catch(_){
      throw Exception("Failed to Load Data");
    }
  }

  void _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception('Connection timeout - Please check your internet');
      case DioExceptionType.sendTimeout:
        throw Exception('Send timeout - Please try again');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout - Server took too long to respond');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Failed to load news';
        throw Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        throw Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        throw Exception('No internet connection');
      default:
        throw Exception('Failed to load news');
    }
  }
}
