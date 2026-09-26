import 'package:flutter/material.dart';
import 'package:news_app/core/controller/bookmark_controller.dart';
import 'package:news_app/core/components/news_article_widget.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: Consumer<BookmarkController>(
        builder: (context, controller, child) {
          if (controller.bookmarkedArticles.isEmpty) {
            return Center(
              child: Text(
                "No Bookmarked Articles Yet",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.bookmarkedArticles.length,
            itemBuilder: (context, index) {
              final article = controller.bookmarkedArticles[index];
              return NewsArticleWidget(articleModel: article);
            },
          );
        },
      ),
    );
  }
}
