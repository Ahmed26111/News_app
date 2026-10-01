import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';
import 'package:news_app/features/home/components/view_all_widget.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/custom_cached_network_image.dart';
import '../../details/news_details_screen.dart';

class TrendingNewsWidget extends StatelessWidget {
  const TrendingNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h300,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background_home_image.png",
              height: AppSizes.h250,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned.fill(
              top: AppSizes.ph60,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: AppSizes.sp22),
                  ),
                  // SizedBox(height: AppSizes.h20),
                  ViewAllWidget(title: "Trending News", onTap: () {}),
                  SizedBox(height: AppSizes.h12),
                  BlocSelector<HomeCubit , HomeState , RequestStatusEnum>(
                    selector: (HomeState state) => state.everythingRequestStatus,
                    builder: (BuildContext context, RequestStatusEnum everythingRequestStatus) {
                      final HomeState state = context.read<HomeCubit>().state;
                      return switch (everythingRequestStatus) {
                        RequestStatusEnum.eLoading || RequestStatusEnum.eInitial => _buildTrendingNewsShimmer(),
                        RequestStatusEnum.eLoaded => SizedBox(
                          height: AppSizes.h140,
                          child: ListView.separated(
                            padding: EdgeInsets.only(left: AppSizes.pw16),
                            itemCount: state.newsEveryThingArticles.take(6).length,
                            separatorBuilder: (_, _) => SizedBox(width: AppSizes.w12),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final article = state.newsEveryThingArticles[index];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NewsDetailsScreen(articleModel: article))
                                  );
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(AppSizes.r8),
                                      child: CustomCachedNetworkImage(
                                        imageUrl: article.urlToImage,
                                        width: AppSizes.w235,
                                        height: AppSizes.h140,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        width: AppSizes.w235,
                                        height: AppSizes.h140,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withValues(alpha: 0.3),
                                              Colors.black.withValues(alpha: 0.7),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(AppSizes.r8),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Padding(
                                        padding: EdgeInsets.all(AppSizes.pw12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title,
                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                color: Theme.of(context).primaryColorLight,
                                                fontWeight: FontWeight.w700,
                                                fontSize: AppSizes.sp14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: AppSizes.h4),
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: (article.urlToImage != "")
                                                      ? NetworkImage(article.urlToImage)
                                                      : AssetImage("assets/images/background_home_image.png"),
                                                  radius: AppSizes.r15,
                                                ),
                                                SizedBox(width: AppSizes.w4),
                                                Expanded(
                                                  child: Text(
                                                    (article.author == "") ? "Unknown" : article.author,
                                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                      color: Theme.of(context).primaryColorLight,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: AppSizes.sp12,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: AppSizes.w4),
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
                                ),
                              );
                            },
                          ),
                        ),
                        RequestStatusEnum.eError => Padding(
                          padding: EdgeInsets.only(top: AppSizes.ph20),
                          child: Text(
                            state.errorMessage!,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
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
      height: AppSizes.h140,
      child: ListView.separated(
        padding: EdgeInsets.only(left: AppSizes.pw16),
        itemCount: 6,
        separatorBuilder: (_, _) => SizedBox(width: AppSizes.w12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: CustomShimmerFromColors(
                    child: ColoredBox(
                      color: Colors.black,
                      child: SizedBox(
                        width: AppSizes.w235,
                        height: AppSizes.h140,
                      ),
                    )
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.pw12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerFromColors(
                        child: ColoredBox(
                          color: Colors.black,
                          child: SizedBox(
                            width: AppSizes.w200,
                            height: AppSizes.h16,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.h4),
                      Row(
                        children: [
                          CustomShimmerFromColors(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: AppSizes.r15,
                              child: SizedBox(
                                width: AppSizes.w15,
                                height: AppSizes.h15,
                              ),
                            ),
                          ),
                          SizedBox(width: AppSizes.w4),
                          CustomShimmerFromColors(
                            child: ColoredBox(
                              color: Colors.black,
                              child: SizedBox(
                                width: AppSizes.w170,
                                height: AppSizes.h16,
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
