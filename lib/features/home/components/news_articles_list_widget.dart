import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/components/news_article_widget.dart';

import '../../../core/constants/app_sizes.dart';
import '../cubit/home_cubit.dart';
import 'new_articles_shimmer.dart';

class NewsArticlesListWidget extends StatelessWidget {
  const NewsArticlesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit , HomeState , RequestStatusEnum>(
      selector: (HomeState state) => state.topHeadLineRequestStatus,
      builder: (BuildContext context, RequestStatusEnum topHeadLineRequestStatus) {
        final HomeState state = context.read<HomeCubit>().state;
        switch(topHeadLineRequestStatus){
          case RequestStatusEnum.eLoading: return NewArticlesShimmer();
          case RequestStatusEnum.eLoaded: return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.ph16),
          child: ListView.builder(
            itemCount: state.newsHeadLineArticles.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsArticleWidget(articleModel: state.newsHeadLineArticles[index]);
            },
          ),
        );
          case RequestStatusEnum.eError: return Padding(
            padding: EdgeInsets.all(AppSizes.pw20),
            child: Text(
              state.errorMessage!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
            ),
          );
        }
      },
    );
  }
}
