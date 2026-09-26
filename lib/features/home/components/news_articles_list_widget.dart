import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/components/news_article_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import 'new_articles_shimmer.dart';

class NewsArticlesListWidget extends StatelessWidget {
  const NewsArticlesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller,_) {
        switch(controller.topHeadLineRequestStatus){
          case RequestStatusEnum.eLoading: return NewArticlesShimmer();
          case RequestStatusEnum.eLoaded: return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.ph16),
          child: ListView.builder(
            itemCount: controller.newsHeadLineArticles.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsArticleWidget(articleModel: controller.newsHeadLineArticles[index]);
            },
          ),
        );
          case RequestStatusEnum.eError: return Padding(
            padding: EdgeInsets.all(AppSizes.pw20),
            child: Text(
              controller.errorMessage!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
            ),
          );
        }
      },
    );
  }
}
