import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imageUrl, this.width, this.height,});

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width ?? 122,
        height: height ?? 68,
        fit: BoxFit.cover,
        placeholder: (context, url) => CustomShimmerFromColors(
            child: ColoredBox(
                color: Colors.black,
                child: SizedBox(
                    width: width ?? 122,
                    height: height ?? 68,
                ),
            )
        ),
        errorWidget: (context, url, error) => ColoredBox(color: Colors.grey.shade300 , child: Icon(Icons.error , color: Colors.red , size: 24,)),
    );
  }
}
