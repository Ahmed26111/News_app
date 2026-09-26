import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/bookmark_repository.dart';
import 'package:news_app/core/mixins/safe_notifier_mixin.dart';
import 'package:news_app/core/model/news_article_model.dart';

class BookmarkController extends ChangeNotifier with SafeNotifier {
  static final BookmarkController _instance = BookmarkController._internal();

  BookmarkController._internal() {
    loadBookmarks();
  }

  factory BookmarkController() => _instance;

  List<NewsArticleModel> bookmarkedArticles = [];

  void loadBookmarks() {
    bookmarkedArticles = BookmarkRepository().getSavedBookmarks();
    notifyListeners();
  }

  Future<void> toggleBookmark(NewsArticleModel article) async {
    await BookmarkRepository().toggleBookmark(article);
    loadBookmarks();
  }

  bool isBookmarked(String url) {
    return BookmarkRepository().isBookmarked(url);
  }
}
