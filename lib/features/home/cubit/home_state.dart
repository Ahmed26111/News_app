part of 'home_cubit.dart';

class HomeState extends Equatable{
  const HomeState({
    this.newsHeadLineArticles = const [],
    this.newsEveryThingArticles = const [],
    this.errorMessage,
    this.selectedCategory = CategoriesEnum.eTopNews,
    this.everythingRequestStatus = RequestStatusEnum.eLoading,
    this.topHeadLineRequestStatus = RequestStatusEnum.eLoading,
  });

  final List<NewsArticleModel> newsHeadLineArticles;
  final List<NewsArticleModel> newsEveryThingArticles;
  final String? errorMessage;
  final CategoriesEnum selectedCategory;
  final RequestStatusEnum everythingRequestStatus;
  final RequestStatusEnum topHeadLineRequestStatus;

  HomeState copyWith({
    List<NewsArticleModel>? newsHeadLineArticles,
    List<NewsArticleModel>? newsEveryThingArticles,
    String? errorMessage,
    CategoriesEnum? selectedCategory,
    RequestStatusEnum? everythingRequestStatus,
    RequestStatusEnum? topHeadLineRequestStatus,
  }) {
    return HomeState(
      newsHeadLineArticles: newsHeadLineArticles ?? this.newsHeadLineArticles,
      newsEveryThingArticles: newsEveryThingArticles ?? this.newsEveryThingArticles,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      everythingRequestStatus: everythingRequestStatus ?? this.everythingRequestStatus,
      topHeadLineRequestStatus: topHeadLineRequestStatus ?? this.topHeadLineRequestStatus,
    );
  }

  @override
  List<Object?> get props => [
    newsHeadLineArticles,
    newsEveryThingArticles,
    errorMessage,
    selectedCategory,
    everythingRequestStatus,
    topHeadLineRequestStatus,
  ];
}
