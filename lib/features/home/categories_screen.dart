import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/news_articles_list_widget.dart';
import '../../core/constants/app_sizes.dart';
import 'components/categories_list_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories"),
      ),
      body: Column(
        children: [
          SizedBox(height: AppSizes.h20,),
          CategoriesListWidget(),
          Expanded(child: NewsArticlesListWidget()),
        ],
      ),
    );
  }
}
