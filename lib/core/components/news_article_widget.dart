import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/model/news_article_model.dart';

import '../constants/app_sizes.dart';
import '../cubit/bookmark_cubit.dart';
import '../widgets/custom_svg_picture_asset.dart';
import '../../features/details/news_details_screen.dart';

class NewsArticleWidget extends StatelessWidget {
  const NewsArticleWidget({super.key, required this.articleModel});

  final NewsArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.pw16, right: AppSizes.pw16, bottom: AppSizes.ph12),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsDetailsScreen(articleModel: articleModel))
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              child: CustomCachedNetworkImage(
                  imageUrl: articleModel.urlToImage,
              ),
            ),
          ),
          SizedBox(width: AppSizes.w8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleModel.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.h4),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: (articleModel.urlToImage != "")
                          ? NetworkImage(articleModel.urlToImage)
                          : AssetImage("assets/images/background_home_image.png"),
                      radius: AppSizes.r15,
                    ),
                    SizedBox(width: AppSizes.w4),
                    Text(
                      getAuthorName(articleModel.author),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: AppSizes.sp12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: AppSizes.w8),
                    Text(
                      articleModel.publishedAt.getDifferenceFormateDateTime(true),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.sp12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    BlocBuilder<BookmarkCubit , BookmarkState>(
                      builder: (context, state) {
                        final isBookmarked = context.read<BookmarkCubit>().isBookmarked(articleModel.url);
                        return IconButton(
                          onPressed: () {
                            context.read<BookmarkCubit>().toggleBookmark(articleModel);
                          },
                          icon: isBookmarked
                              ? CustomSvgPictureAsset.withColorFilter(
                                  path: "assets/images/bookmark_icon.svg",
                                  color: Theme.of(context).primaryColor,
                                )
                              : CustomSvgPictureAsset(
                                  path: "assets/images/bookmark_icon.svg",
                                ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getAuthorName(String author){
    if(author.isEmpty){
      return "Unknown";
    }
    else{
      if(author.length > 9){
        return "${author.substring(0 , 9)}...";
      }
      return author;
    }
  }
}
