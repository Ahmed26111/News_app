import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNewsWidget extends StatelessWidget {
  const TrendingNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          Image.asset("assets/images/background_home_image.png", height: 250, width: double.infinity, fit: BoxFit.fill),
          Positioned.fill(
            top: 60,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "View all",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Consumer<HomeController>(
                  builder: (BuildContext context, HomeController controller, _) {
                    return switch(controller.everythingRequestStatus){
                      RequestStatusEnum.eLoading => Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(color: Theme.of(context).primaryColorLight,),
                      ),
                      RequestStatusEnum.eLoaded => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 140,
                          child: ListView.separated(
                            itemCount: controller.newsEveryThingArticles.length,
                            separatorBuilder: (_, _) => SizedBox(width: 12),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final article = controller.newsEveryThingArticles[index];
                              return Container(
                                width: 235,
                                height: 140,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: (article.urlToImage != "")
                                        ? NetworkImage(article.urlToImage)
                                        : AssetImage("assets/images/background_home_image.png"),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    article.title,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      RequestStatusEnum.eError => Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          controller.errorMessage!,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
                        ),
                      ),
                    };
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
