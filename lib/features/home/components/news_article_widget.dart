import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/%20models/news_article_model.dart';

import '../../../core/utils/utility.dart';

class NewsArticleWidget extends StatelessWidget {
  const NewsArticleWidget({super.key, required this.articleModel});

  final NewsArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(
                imageUrl: articleModel.urlToImage,
            ),
          ),
          SizedBox(width: 8),
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
                SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: (articleModel.urlToImage != "")
                          ? NetworkImage(articleModel.urlToImage)
                          : AssetImage("assets/images/background_home_image.png"),
                      radius: 15,
                    ),
                    SizedBox(width: 4),
                    Text(
                      getAuthorName(articleModel.author),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 8),
                    Text(
                      articleModel.publishedAt.getDifferenceFormateDateTime(true),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.bookmark_outline),
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
