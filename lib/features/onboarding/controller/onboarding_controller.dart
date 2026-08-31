import 'package:flutter/material.dart';

import '../../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../authentication/login_screen.dart';
import '../models/onboarding_model.dart';

class OnboardingController with ChangeNotifier {
  final PageController controller = PageController();
  int currentPage = 0;
  bool isLastPage = false;

  void changePage(int nextPage) {
    currentPage = nextPage;
    _isLastPage(nextPage);
    notifyListeners();
  }

  void onFinish(BuildContext context) async {
    await SharedPreferencesManager().setBool(
      SharedPreferencesKeys.onBoardingCompleted,
      true,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }

  void _isLastPage(int index) {
    isLastPage = (index == OnboardingModel.onboardingList.length - 1);
  }
}
