import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';

class NewArticlesShimmer extends StatelessWidget {
  const NewArticlesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      sliver: SliverList.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomShimmerFromColors(
                    child: ColoredBox(
                      color: Colors.black,
                      child: SizedBox(
                        width: 122,
                        height: 68,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerFromColors(
                        child: ColoredBox(
                            color: Colors.black,
                            child: SizedBox(
                              width: 180,
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
                            ),
                          ),
                          SizedBox(width: 4),
                          CustomShimmerFromColors(
                            child: ColoredBox(
                              color: Colors.black,
                              child: SizedBox(
                                width: 150,
                                height: 16,
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
