import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/components/sliver_new_articles_shimmer.dart';
import 'package:news_app/features/home/components/news_article_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';

class SliverNewsArticlesListWidget extends StatelessWidget {
  const SliverNewsArticlesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller,_) {
        switch(controller.topHeadLineRequestStatus){
          case RequestStatusEnum.eLoading: return SliverNewArticlesShimmer();
          case RequestStatusEnum.eLoaded: return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.ph16),
          sliver: SliverList.builder(
            itemCount: controller.newsHeadLineArticles.take(10).length,
            itemBuilder: (BuildContext context, int index) {
              return NewsArticleWidget(articleModel: controller.newsHeadLineArticles[index]);
            },
          ),
        );
          case RequestStatusEnum.eError: return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.pw20),
              child: Text(
                controller.errorMessage!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
              ),
            ),
          );
        }
      },
    );
  }
}
