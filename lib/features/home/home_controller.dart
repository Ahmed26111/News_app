import 'package:flutter/material.dart';
import ' models/news_article_model.dart';
import '../../core/data_source/remote_data/api_configuration.dart';
import '../../core/data_source/remote_data/api_service.dart';

class HomeController with ChangeNotifier {
  bool isEverythingLoading = true;
  bool isTopHeadLineLoading = true;
  List<NewsArticleModel> newsHeadLineArticles = [];
  List<NewsArticleModel> newsEveryThingArticles = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  void callEverythingEndPoint() async {
    isEverythingLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      Map<String, dynamic> data = await apiService.get(
        endPoint: ApiConfiguration.everythingEndPoint,
        query: {"q": "bitcoin", "pageSize": "10", "page": "1"},
      );
      newsEveryThingArticles = (data["articles"] as List<dynamic>)
          .map(
            (json) => NewsArticleModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      isEverythingLoading = false;
      errorMessage = null;
    } catch (e) {
      isEverythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void callHeadLineEndPoint() async {
    isTopHeadLineLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      Map<String, dynamic> data = await apiService.get(
        endPoint: ApiConfiguration.headLineEndPoint,
        query: {"country": "us", "pageSize": "10", "page": "1"},
      );
      newsHeadLineArticles = (data["articles"] as List<dynamic>)
          .map(
            (json) => NewsArticleModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      isTopHeadLineLoading = false;
      errorMessage = null;
    } catch (e) {
      isTopHeadLineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
