import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../core/theme/light_color_constant.dart';
import '../authentication/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => OnboardingCubit(),
      child: Builder(
        builder: (context) {
          final controller = context.read<OnboardingCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: LightColorConstant.scaffoldBackgroundColor,
              actions: [
                BlocBuilder<OnboardingCubit , OnboardingState>(
                  builder: (BuildContext context, OnboardingState state) {
                    return (!state.isLastPage)
                        ? TextButton(
                            onPressed: () {
                              onFinish(context);
                            },
                            child: Text("Skip"),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.pw16,
                right: AppSizes.pw16,
                top: AppSizes.ph30,
                bottom: AppSizes.ph20,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) => controller.changePage(index),
                      itemCount: OnboardingModel.onboardingList.length,
                      itemBuilder: (context, index) {
                        final model = OnboardingModel.onboardingList[index];
                        return Column(
                          children: [
                            Image.asset(
                              model.imagePath,
                              width: MediaQuery.of(context).size.width * 0.8, //? 80% possible width
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: AppSizes.h24),
                            Text(model.title, style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(height: AppSizes.h12),
                            Text(
                              model.description,
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: AppSizes.h24),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: OnboardingModel.onboardingList.length,
                    axisDirection: Axis.horizontal,
                    effect: WormEffect(
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Theme.of(context).secondaryHeaderColor,
                      spacing: AppSizes.w6,
                    ),
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.h84),
                  BlocBuilder<OnboardingCubit ,OnboardingState>(
                    builder: (BuildContext context, OnboardingState state) {
                      return FilledButton(
                        onPressed: () {
                          if (!state.isLastPage) {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            onFinish(context);
                          }
                        },
                        child: Text((state.isLastPage) ? "Get Started" : "Next"),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onFinish(BuildContext context) async {
    await SharedPreferencesManager().setBool(SharedPreferencesKeys.onBoardingCompleted, true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

}
