import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/components/sliver_categories_list_widget.dart';
import 'package:news_app/features/home/components/sliver_news_articles_list_widget.dart';
import 'package:news_app/features/home/components/trending_news_widget.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

import '../../core/data_source/remote_data/news/news_api_service.dart';
import '../../core/repos/news_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(newsRepository: NewsRepository(apiService: NewsApiService())),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [TrendingNewsWidget(), SliverCategoriesListWidget(), SliverNewsArticlesListWidget()],
        ),
      ),
    );
  }
}
