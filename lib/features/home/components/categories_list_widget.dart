import 'package:flutter/material.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import '../../../core/constants/app_sizes.dart';
import '../widgets/custom_category_text_button.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.pw16 ,right: AppSizes.pw8),
      child: SizedBox(
        height: AppSizes.h30,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: CategoriesEnum.values.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(width: AppSizes.w12,),
          itemBuilder: (BuildContext context, int index) {
            return CustomCategoryTextButton(category: CategoriesEnum.values[index]);
          },
        ),
    ),);
  }
}
