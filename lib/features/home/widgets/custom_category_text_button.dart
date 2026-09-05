import 'package:flutter/material.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';

class CustomCategoryTextButton extends StatelessWidget {
  const CustomCategoryTextButton({super.key, required this.category});

  final CategoriesEnum category;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller,_) {
        bool isSelected = controller.selectedCategory == category;
        return TextButton(
          onPressed: (){
            controller.changeSelectedCategory(category);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: IntrinsicWidth(
            child: Column(
              children: [
                Text(
                  category.name,
                  style: (isSelected)
                      ?Theme.of(context).textTheme.titleSmall
                      :Theme.of(context).textTheme.bodyMedium,
                ),
                if(isSelected)
                  ...[
                    SizedBox(height: AppSizes.h4,),
                    Divider(height: AppSizes.h3, thickness: 3, color: Theme.of(context).textTheme.titleSmall?.color,)
                  ]
              ],
            ),
          ),
        );
      },
    );
  }
}
