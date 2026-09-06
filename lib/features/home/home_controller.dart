import 'package:flutter/material.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/repos/news_repository.dart';
import ' models/news_article_model.dart';
import '../../core/mixins/safe_notifier_mixin.dart';

class HomeController extends ChangeNotifier with SafeNotifier{
  List<NewsArticleModel> newsHeadLineArticles = [];
  List<NewsArticleModel> newsEveryThingArticles = [];
  String? errorMessage;


  HomeController({required this.newsRepository}) {
    callHeadLineEndPoint();
    callEverythingEndPoint();
  }

  CategoriesEnum selectedCategory = CategoriesEnum.eTopNews;

  RequestStatusEnum everythingRequestStatus = RequestStatusEnum.eLoading;

  RequestStatusEnum topHeadLineRequestStatus = RequestStatusEnum.eLoading;

  final BaseNewsRepository newsRepository;

  void callEverythingEndPoint() async {
    everythingRequestStatus = RequestStatusEnum.eLoading;
    errorMessage = null;
    notifyListeners();
    try {
      newsEveryThingArticles = await newsRepository.callEverythingEndPoint();
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
    String category = selectedCategory.name.toLowerCase();
    try {
      newsHeadLineArticles = await newsRepository.callHeadLineEndPoint(
        selectedCategory: (selectedCategory == CategoriesEnum.eTopNews) ? null : category,
      );
      topHeadLineRequestStatus = RequestStatusEnum.eLoaded;
      errorMessage = null;
    } catch (e) {
      topHeadLineRequestStatus = RequestStatusEnum.eError;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void changeSelectedCategory(CategoriesEnum category) {
    selectedCategory = category;
    callHeadLineEndPoint();
    notifyListeners();
  }
}
