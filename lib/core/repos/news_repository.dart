import '../../../core/data_source/remote_data/api_configuration.dart';
import '../../../core/data_source/remote_data/api_service.dart';
import '../model/news_article_model.dart';

abstract class BaseNewsRepository {

  Future<List<NewsArticleModel>> callEverythingEndPoint({String query = "bitcoin"});

  Future<List<NewsArticleModel>> callHeadLineEndPoint({String? selectedCategory});
}


class NewsRepository extends BaseNewsRepository {
  NewsRepository({required this.apiService});

  final BaseApiService apiService;

  @override
  Future<List<NewsArticleModel>> callEverythingEndPoint({String query = "bitcoin"}) async {
    Map<String, dynamic> data = await apiService.get(
      endPoint: ApiConfiguration.everythingEndPoint,
      query: {"q": query, "pageSize": "20", "page": "1"},
    );
    return (data["articles"] as List<dynamic>)
        .map((json) => NewsArticleModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> callHeadLineEndPoint({String? selectedCategory}) async {
    Map<String, dynamic> data = await apiService.get(
      endPoint: ApiConfiguration.headLineEndPoint,
      query: {"country": "us", "category": selectedCategory, "pageSize": "20", "page": "1"},
    );
    return (data["articles"] as List<dynamic>)
        .map((json) => NewsArticleModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
