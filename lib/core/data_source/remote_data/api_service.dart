import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/data_source/remote_data/api_configuration.dart';

abstract class BaseApiService{
  Future<dynamic> get({required String baseUrl , required String endPoint, Map<String, dynamic>? query});
  Future<dynamic> post({required String baseUrl , required String endPoint, Map<String, dynamic>? body});
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
  Future<dynamic> post({required String baseUrl, required String endPoint, Map<String, dynamic>? body}) async {
    Uri uri = Uri.https(baseUrl, endPoint);
    try{
      final response = await http.post(uri, body: jsonEncode(body) , headers: {"Content-Type": "application/json"});
      return jsonDecode(response.body) as Map<String, dynamic>;
    }catch(_){
    throw Exception("Failed to Load Data");
    }
  }
}
