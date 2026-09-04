import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/components/new_articles_shimmer.dart';
import 'package:news_app/features/home/components/news_article_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class NewsArticlesListWidget extends StatelessWidget {
  const NewsArticlesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller,_) {
        switch(controller.topHeadLineRequestStatus){
          case RequestStatusEnum.eLoading: return NewArticlesShimmer();
          case RequestStatusEnum.eLoaded: return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverList.builder(
            itemCount: controller.newsHeadLineArticles.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsArticleWidget(articleModel: controller.newsHeadLineArticles[index]);
            },
          ),
        );
          case RequestStatusEnum.eError: return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                controller.errorMessage!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
              ),
            ),
          );
        }
      },
    );
  }
}
