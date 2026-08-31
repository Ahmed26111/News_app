import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/data_source/remote_data/api_configuration.dart';

class ApiService {
  Future<dynamic> get({required String endPoint, Map<String, dynamic>? query}) async {
    Uri uri = Uri.https(ApiConfiguration.baseUrl, "${ApiConfiguration.version}$endPoint", {
      "apiKey": ApiConfiguration.apiKey,
      ...?query,
    });
    try{
      return jsonDecode((await http.get(uri)).body) as Map<String, dynamic>;
    }catch(_){
      throw Exception("Failed to Load Data");
    }
  }
}
