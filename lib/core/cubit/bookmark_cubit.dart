import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_source/local_data/bookmark_repository.dart';
import '../model/news_article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState());

  void loadBookmarks() {
     emit(state.copyWith(bookmarkedArticles: BookmarkRepository().getSavedBookmarks()));
  }

  Future<void> toggleBookmark(NewsArticleModel article) async {
    await BookmarkRepository().toggleBookmark(article);
    loadBookmarks();
  }

  bool isBookmarked(String url) {
    return BookmarkRepository().isBookmarked(url);
  }
}
