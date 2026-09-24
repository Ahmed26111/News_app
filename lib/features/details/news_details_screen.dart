import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_color_constant.dart';
import 'package:news_app/core/widgets/custom_svg_picture_asset.dart';
import 'package:news_app/features/home/%20models/news_article_model.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/widgets/custom_cached_network_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.articleModel});

  final NewsArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: AppSizes.ph20, left: AppSizes.pw16, right: AppSizes.pw16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: CustomCachedNetworkImage(
                  imageUrl: articleModel.urlToImage,
                  height: AppSizes.h228,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                  articleModel.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: LightColorConstant.textPrimaryColor
                  ),
              ),
              SizedBox(height: AppSizes.h8),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (articleModel.urlToImage != "")
                        ? NetworkImage(articleModel.urlToImage)
                        : AssetImage("assets/images/background_home_image.png"),
                    radius: AppSizes.r20,
                  ),
                  SizedBox(width: AppSizes.w4,),
                  Text(
                    getAuthorName(articleModel.author),
                    style: Theme.of(context).textTheme.labelSmall,
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
                  IconButton(
                    onPressed: (){},
                    icon: CustomSvgPictureAsset(
                        path: "assets/images/bookmark_icon.svg"
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                  articleModel.content,
                  style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
  String getAuthorName(String author){
    if(author.isEmpty){
      return "Unknown";
    }
    else{
      if(author.length > 22){
        return "${author.substring(0 , 22)}...";
      }
      return author;
    }
  }
}
