import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/data_source/remote_data/api_configuration.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/features/home/%20models/news_article_model.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..callEverythingEndPoint(),
      builder: (context , _) {
        return Scaffold(
          body: Consumer<HomeController>(
            builder: (BuildContext context, HomeController controller, _) {
              return Center(
                child: (controller.isEverythingLoading)
                    ? CircularProgressIndicator()
                    : (controller.errorMessage != null)
                    ? Text(
                  controller.errorMessage!,
                  style: Theme.of(context).textTheme.titleLarge,
                )
                    : ListView.builder(
                  itemCount: controller.newsEveryThingArticles.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.newsEveryThingArticles[index].title,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
