import 'package:dio/dio.dart';
import 'dio_config.dart';

class DioExample {
  static final dio = DioConfig.createDio();

  static Future<void> exampleGetRequest() async {
    try{
      await dio.get("products");
    }catch(e){}
  }

  static Future<void> exampleGetRequestWithQueryParameter() async {
    try{
      await dio.get("products/search", queryParameters: {"q": "phone"});
    }catch(e){}
  }

  static Future<void> examplePostRequest() async {
    try{
      await dio.post("products/add", data: {"title": "adsdasdasd"});
    }catch(e){}
  }

  static Future<void> examplePutRequest() async {
    try{
      await dio.put("products/1", data: {"title": 'iPhone Galaxy +1'});
    }catch(e){}
  }

  static Future<void> exampleDeleteRequest() async {
    try{
      await dio.delete("products/1");
    }catch(e){}
  }

  static Future<void> exampleErrorHandling() async {
    try {
      await dio.post("lfnal;ksnflsaknflkasn;fsalnf");
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw "Connection timeout";
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
        case DioExceptionType.transformTimeout:
          throw e.message.toString();
      }
    }
  }
}
