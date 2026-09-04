import 'package:flutter/material.dart';
import 'package:news_app/core/enum/categories_enum.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_widget.dart';
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
                  MaterialPageRoute(builder: (context)=>CategoriesScreen())
              );
            },
            title: "Categories",
            titleColor: Theme.of(context).textTheme.labelLarge?.color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16 ,right: 8),
            child: SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: CategoriesEnum.values.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 12,),
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
