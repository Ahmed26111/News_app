import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theme/light_color_constant.dart';
import 'controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: LightColorConstant.scaffoldBackgroundColor,
            actions: [
              Consumer<OnboardingController>(
                builder:
                    (BuildContext context, OnboardingController textButtonController, _) {
                      return (!textButtonController.isLastPage)
                          ? TextButton(onPressed: () {textButtonController.onFinish(context);}, child: Text("Skip"))
                          : SizedBox();
                    },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 30,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.controller,
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
                          SizedBox(height: 24),
                          Text(
                            model.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 12),
                          Text(
                            model.description,
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (BuildContext context, OnboardingController indicatorController,_) {
                    return SmoothPageIndicator(
                      controller: indicatorController.controller,
                      count: OnboardingModel.onboardingList.length,
                      axisDirection: Axis.horizontal,
                      effect: WormEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: Theme.of(context).secondaryHeaderColor,
                        spacing: 6,
                      ),
                      onDotClicked: (index) {
                        indicatorController.controller.animateToPage(
                            index,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 84,),
                Consumer<OnboardingController>(
                  builder: (BuildContext context, OnboardingController filledButtonController, _) {
                    return FilledButton(
                      onPressed: () {
                        if(!filledButtonController.isLastPage){
                          filledButtonController.controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }else{
                           filledButtonController.onFinish(context);
                        }
                      },
                      child: Text((filledButtonController.isLastPage) ? "Get Started" : "Next"),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
