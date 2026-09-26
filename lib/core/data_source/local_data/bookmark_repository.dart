import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/hive_constants.dart';
import 'package:news_app/core/model/news_article_model.dart';

class BookmarkRepository {
  static final BookmarkRepository _instance = BookmarkRepository._();

  BookmarkRepository._();

  factory BookmarkRepository() => _instance;

  late final Box<NewsArticleModel> _bookmarksBox;

  Future<void> init() async {
    Hive.registerAdapter(NewsArticleModelAdapter());
    _bookmarksBox = await Hive.openBox<NewsArticleModel>(HiveConstants.bookmarksBoxKey);
  }

  List<NewsArticleModel> getSavedBookmarks() {
    return _bookmarksBox.values.toList();
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    await _bookmarksBox.put(article.url, article);
  }

  Future<void> removeBookmark(String url) async {
    await _bookmarksBox.delete(url);
  }

  bool isBookmarked(String url) {
    return _bookmarksBox.containsKey(url);
  }

  Future<bool> toggleBookmark(NewsArticleModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookmark(article.url);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }
}
