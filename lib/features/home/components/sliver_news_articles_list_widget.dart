import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/components/sliver_new_articles_shimmer.dart';
import 'package:news_app/core/components/news_article_widget.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

import '../../../core/constants/app_sizes.dart';

class SliverNewsArticlesListWidget extends StatelessWidget {
  const SliverNewsArticlesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit , HomeState , RequestStatusEnum>(
      selector: (HomeState state) => state.topHeadLineRequestStatus,
      builder: (BuildContext context, RequestStatusEnum topHeadLineRequestStatus){
        final HomeState state = context.read<HomeCubit>().state;
        switch(topHeadLineRequestStatus){
          case RequestStatusEnum.eLoading: return SliverNewArticlesShimmer();
          case RequestStatusEnum.eLoaded: return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.ph16),
          sliver: SliverList.builder(
            itemCount: state.newsHeadLineArticles.take(10).length,
            itemBuilder: (BuildContext context, int index) {
              return NewsArticleWidget(articleModel: state.newsHeadLineArticles[index]);
            },
          ),
        );
          case RequestStatusEnum.eError: return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.pw20),
              child: Text(
                state.errorMessage!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
              ),
            ),
          );
        }
      },
    );
  }
}
