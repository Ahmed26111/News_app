part of 'bookmark_cubit.dart';

class BookmarkState extends Equatable{
  final List<NewsArticleModel> bookmarkedArticles;

  const BookmarkState({this.bookmarkedArticles = const []});

  BookmarkState copyWith({
    List<NewsArticleModel>? bookmarkedArticles,
  }) {
    return BookmarkState(
      bookmarkedArticles: bookmarkedArticles ?? this.bookmarkedArticles,
    );
  }

  @override
  List<Object?> get props => [bookmarkedArticles];
}

