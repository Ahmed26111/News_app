import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/utils/utility.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';
import 'package:news_app/features/home/components/view_all_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_cached_network_image.dart';

class TrendingNewsWidget extends StatelessWidget {
  const TrendingNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background_home_image.png",
              height: 250,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned.fill(
              top: 60,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                  // SizedBox(height: 20),
                  ViewAllWidget(title: "Trending News", onTap: () {}),
                  SizedBox(height: 12),
                  Consumer<HomeController>(
                    builder: (BuildContext context, HomeController controller, _) {
                      return switch (controller.everythingRequestStatus) {
                        RequestStatusEnum.eLoading => _buildTrendingNewsShimmer(),
                        RequestStatusEnum.eLoaded => SizedBox(
                          height: 140,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            itemCount: controller.newsEveryThingArticles.take(6).length,
                            separatorBuilder: (_, _) => SizedBox(width: 12),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final article = controller.newsEveryThingArticles[index];
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CustomCachedNetworkImage(
                                      imageUrl: article.urlToImage,
                                      width: 235,
                                      height: 140,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      width: 235,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withValues(alpha: 0.3),
                                            Colors.black.withValues(alpha: 0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title,
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: Theme.of(context).primaryColorLight,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: (article.urlToImage != "")
                                                    ? NetworkImage(article.urlToImage)
                                                    : AssetImage("assets/images/background_home_image.png"),
                                                radius: 15,
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  (article.author == "") ? "Unknown" : article.author,
                                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                    color: Theme.of(context).primaryColorLight,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                article.publishedAt.getDifferenceFormateDateTime(),
                                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                  color: Theme.of(context).primaryColorLight,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }

  Widget _buildTrendingNewsShimmer(){
    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        itemCount: 6,
        separatorBuilder: (_, _) => SizedBox(width: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomShimmerFromColors(
                    child: ColoredBox(
                      color: Colors.black,
                      child: SizedBox(
                        width: 235,
                        height: 140,
                      ),
                    )
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerFromColors(
                        child: ColoredBox(
                          color: Colors.black,
                          child: SizedBox(
                            width: 200,
                            height: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          CustomShimmerFromColors(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 15,
                              child: SizedBox(
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          CustomShimmerFromColors(
                            child: ColoredBox(
                              color: Colors.black,
                              child: SizedBox(
                                width: 170,
                                height: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
