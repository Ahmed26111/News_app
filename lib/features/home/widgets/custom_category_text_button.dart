import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import '../../../core/constants/app_sizes.dart';

class CustomCategoryTextButton extends StatelessWidget {
  const CustomCategoryTextButton({super.key, required this.category});

  final CategoriesEnum category;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit , HomeState , CategoriesEnum>(
      selector: (HomeState state) => state.selectedCategory,
      builder: (BuildContext context, CategoriesEnum selectedCategory) {
        bool isSelected = selectedCategory == category;
        return TextButton(
          onPressed: (){
            context.read<HomeCubit>().changeSelectedCategory(category);
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
