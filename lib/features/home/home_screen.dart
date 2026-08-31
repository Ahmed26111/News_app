import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/trending_news_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..callEverythingEndPoint(),
      builder: (context, _) {
        return Consumer<HomeController>(
          builder: (BuildContext context, HomeController controller, _) {
            return Center(
                child: (controller.isEverythingLoading)
                    ? CircularProgressIndicator()
                    : (controller.errorMessage != null)
                    ? Text(
                      controller.errorMessage!,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                    : Scaffold(
                        body: Column(
                          children: [
                            TrendingNewsWidget(),
                          ],
                        ),
                    ),
            );
          },
        );
      },
    );
  }
}
