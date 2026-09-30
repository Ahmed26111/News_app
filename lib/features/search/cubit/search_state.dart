part of 'search_cubit.dart';

class SearchState extends Equatable{
  final List<NewsArticleModel> newsEveryThingArticles;
  final String? errorMessage;
  final RequestStatusEnum everythingRequestStatus;

  const SearchState({
    this.newsEveryThingArticles = const [],
    this.errorMessage,
    this.everythingRequestStatus = RequestStatusEnum.eLoading,
  });

  SearchState copyWith({
    List<NewsArticleModel>? newsEveryThingArticles,
    String? errorMessage,
    RequestStatusEnum? everythingRequestStatus,
  }) {
    return SearchState(
      newsEveryThingArticles: newsEveryThingArticles ?? this.newsEveryThingArticles,
      errorMessage: errorMessage,
      everythingRequestStatus: everythingRequestStatus ?? this.everythingRequestStatus,
    );
  }

  @override
  List<Object?> get props => [newsEveryThingArticles, errorMessage, everythingRequestStatus];
}
