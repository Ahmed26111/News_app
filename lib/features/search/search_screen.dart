import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/theme/light_color_constant.dart';
import 'package:news_app/core/widgets/custom_shimmer_from_colors.dart';
import 'package:news_app/core/widgets/custom_text_field.dart';
import 'package:news_app/features/search/search_screen_controller.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/remote_data/api_service.dart';
import '../../core/repos/news_repository.dart';
import '../details/news_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: ChangeNotifierProvider(
        create: (_) => SearchScreenController(newsRepository: NewsRepository(apiService: ApiService())),
        child: Consumer<SearchScreenController>(
          builder: (BuildContext context, SearchScreenController controller, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.callEverythingEndPoint();
                    },
                  ),
                  SizedBox(height: AppSizes.h10,),
                  switch(controller.everythingRequestStatus){
                    RequestStatusEnum.eLoading => _buildSearchResultShimmer(),
                    RequestStatusEnum.eLoaded => Expanded(
                      child: ListView.separated(
                        itemCount: controller.newsEveryThingArticles.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(),
                        itemBuilder: (context, index) {
                          final model = controller.newsEveryThingArticles[index];
                          return ListTile(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewsDetailsScreen(articleModel: model))
                              );
                            },
                            contentPadding : EdgeInsets.symmetric(horizontal: AppSizes.pw16 , vertical: AppSizes.ph8),
                            leading: Icon(
                              Icons.search,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              size: AppSizes.r25,
                            ),
                            title: Text(
                              model.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                    RequestStatusEnum.eError => Padding(
                      padding: EdgeInsets.all(AppSizes.pw20),
                      child: Text(
                          controller.errorMessage!,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.sp20),
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResultShimmer() {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          return CustomShimmerFromColors(
              child: ColoredBox(
                color: LightColorConstant.placeholderTextColor,
                child: SizedBox(
                  height: AppSizes.h44,
                  width: AppSizes.w150,
                ),
              )
          );
        },
      ),
    );
  }
}
