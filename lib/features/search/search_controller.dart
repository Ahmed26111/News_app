import 'package:flutter/material.dart';
import 'package:news_app/core/mixins/safe_notifier_mixin.dart';

import '../../core/enum/request_status_enum.dart';
import '../../core/repos/news_repository.dart';
import '../home/ models/news_article_model.dart';

class SearchController extends ChangeNotifier with SafeNotifier{
  List<NewsArticleModel> newsEveryThingArticles = [];
  String? errorMessage;
  RequestStatusEnum everythingRequestStatus = RequestStatusEnum.eLoading;
  final BaseNewsRepository newsRepository;

  SearchController({required this.newsRepository}) {
    callEverythingEndPoint();
  }

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

}