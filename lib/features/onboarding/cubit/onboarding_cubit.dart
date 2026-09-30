import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/onboarding_model.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void changePage(int nextPage) {
    emit(OnboardingState(currentPage: nextPage));
    _isLastPage(nextPage);
  }


  void _isLastPage(int index) {
    emit(OnboardingState(isLastPage: (index == OnboardingModel.onboardingList.length - 1)));
  }
}
