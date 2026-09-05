import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';

import '../../../core/constants/app_sizes.dart';

class SliverNewArticlesShimmer extends StatelessWidget {
  const SliverNewArticlesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.ph16),
      sliver: SliverList.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: AppSizes.pw16, right: AppSizes.pw16, bottom: AppSizes.ph12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                  child: CustomShimmerFromColors(
                    child: ColoredBox(
                      color: Colors.black,
                      child: SizedBox(
                        width: AppSizes.w122,
                        height: AppSizes.h68,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.w8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerFromColors(
                        child: ColoredBox(
                            color: Colors.black,
                            child: SizedBox(
                              width: AppSizes.w180,
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
                            ),
                          ),
                          SizedBox(width: AppSizes.w4),
                          CustomShimmerFromColors(
                            child: ColoredBox(
                              color: Colors.black,
                              child: SizedBox(
                                width: AppSizes.w150,
                                height: AppSizes.h16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
