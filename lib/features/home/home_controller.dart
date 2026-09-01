import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import ' models/news_article_model.dart';
import '../../core/data_source/remote_data/api_configuration.dart';
import '../../core/data_source/remote_data/api_service.dart';

class HomeController with ChangeNotifier {
  List<NewsArticleModel> newsHeadLineArticles = [];
  List<NewsArticleModel> newsEveryThingArticles = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  RequestStatusEnum everythingRequestStatus = RequestStatusEnum.eLoading;

  RequestStatusEnum topHeadLineRequestStatus = RequestStatusEnum.eLoading;

  void callEverythingEndPoint() async {
    everythingRequestStatus = RequestStatusEnum.eLoading;
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
      everythingRequestStatus = RequestStatusEnum.eLoaded;
      errorMessage = null;
    } catch (e) {
      everythingRequestStatus = RequestStatusEnum.eError;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void callHeadLineEndPoint() async {
    topHeadLineRequestStatus = RequestStatusEnum.eLoading;
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
      topHeadLineRequestStatus = RequestStatusEnum.eLoaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineRequestStatus = RequestStatusEnum.eError;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
