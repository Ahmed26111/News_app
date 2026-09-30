import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/news_article_widget.dart';

import '../../core/cubit/bookmark_cubit.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state.bookmarkedArticles.isEmpty) {
            return Center(
              child: Text(
                "No Bookmarked Articles Yet",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return ListView.builder(
            itemCount: state.bookmarkedArticles.length,
            itemBuilder: (context, index) {
              final article = state.bookmarkedArticles[index];
              return NewsArticleWidget(articleModel: article);
            },
          );
        },
      ),
    );
  }
}
