import 'package:flutter/material.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_widget.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../widgets/custom_category_text_button.dart';

class SliverCategoriesListWidget extends StatelessWidget {
  const SliverCategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ViewAllWidget(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_)=> ChangeNotifierProvider.value(
                        value: context.read<HomeController>(),
                        child: CategoriesScreen(),
                      )
                  )
              );
            },
            title: "Categories",
            titleColor: Theme.of(context).textTheme.labelLarge?.color,
          ),
          Padding(
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
          ),),
        ],
      ),
    );
  }
}
