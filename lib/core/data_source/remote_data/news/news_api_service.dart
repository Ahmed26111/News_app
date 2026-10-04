import 'package:dio/dio.dart';
import 'news_dio_config.dart';


abstract class NewsBaseApiService{
  Future<dynamic> get({required String endPoint, Map<String, dynamic>? query});
}


class NewsApiService extends NewsBaseApiService{
  final Dio dio = NewsDioConfig.createDio();
  @override
  Future<dynamic> get({required String endPoint, Map<String, dynamic>? query}) async {
    try{
      final response = await dio.get(endPoint , queryParameters: query);
      return response.data as Map<String, dynamic>;
    }
    on DioException catch(e){
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
    catch(_){
      throw Exception("Failed to Load Data");
    }
  }

}
