import 'package:news_app/core/extensions/date_time_extension.dart';

class NewsArticleModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "author": author,
      "title": title,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      "publishedAt": publishedAt,
      "content": content,
    };
  }

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: DateTime.tryParse(json["publishedAt"]) ?? DateTime.now(),
      content: json["content"] ?? "",
    );
  }

  NewsArticleModel copyWith({
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) {
    return NewsArticleModel(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'NewsArticleModel(author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: ${publishedAt.getDifferenceFormateDateTime(true)}, content: $content)';
  }
}
