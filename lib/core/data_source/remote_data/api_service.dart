import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/data_source/remote_data/api_configuration.dart';

import '../local_data/user_repository.dart';

abstract class BaseApiService{
  Future<dynamic> get({required String baseUrl , required String endPoint, Map<String, dynamic>? query});
  Future<dynamic> post({required String baseUrl , required String endPoint, Map<String, dynamic>? body , String? token});
  Future<dynamic> getWithToken({required String baseUrl , required String endPoint, Map<String, dynamic>? body});
}


class ApiService extends BaseApiService{
  @override
  Future<dynamic> get({required String baseUrl ,required String endPoint, Map<String, dynamic>? query}) async {
    Uri uri = Uri.https(baseUrl, "${ApiConfiguration.version}$endPoint", {
      "apiKey": ApiConfiguration.apiKey,
      ...?query,
    });
    try{
      return jsonDecode((await http.get(uri)).body) as Map<String, dynamic>;
    }catch(_){
      throw Exception("Failed to Load Data");
    }
  }

  @override
  Future<dynamic> post({required String baseUrl, required String endPoint, Map<String, dynamic>? body , String? token}) async {
    Uri uri = Uri.https(baseUrl, endPoint);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if(token != null){
      headers["Authorization"] = "Bearer $token";
    }

    try{
      final response = await http.post(uri, body: jsonEncode(body) , headers: headers);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if(response.statusCode >= 200 && response.statusCode < 300){
        return responseBody;
      }else{
        throw Exception(responseBody["message"] ?? "Failed to Load Data");
      }
    }catch(_){
    throw Exception("Failed to Load Data");
    }
  }

  @override
  Future<dynamic> getWithToken({required String baseUrl, required String endPoint, Map<String, dynamic>? body}) async{
    Uri uri = Uri.https(baseUrl, endPoint);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    final token = UserRepository().getCurrentUser()?.accessToken;
    if(token != null){
      headers["Authorization"] = "Bearer $token";
    }

    try{
      final response = await http.get(uri, headers: headers);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if(response.statusCode >= 200 && response.statusCode < 300){
        return responseBody;
      }else{
        throw Exception(responseBody["message"] ?? "Failed to Load Data");
      }
    }catch(_){
      throw Exception("Failed to Load Data");
    }
  }
}
