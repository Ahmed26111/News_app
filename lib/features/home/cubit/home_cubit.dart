import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enum/categories_enum.dart';
import '../../../core/enum/request_status_enum.dart';
import '../../../core/model/news_article_model.dart';
import '../../../core/repos/news_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.newsRepository}) : super(HomeState()){
    callHeadLineEndPoint();
    callEverythingEndPoint();
  }

  final BaseNewsRepository newsRepository;

  void callEverythingEndPoint() async {
    try {
      final articles = await newsRepository.callEverythingEndPoint();
      emit(state.copyWith(
        newsEveryThingArticles: articles,
        everythingRequestStatus: RequestStatusEnum.eLoaded,
        errorMessage: null,
      ));
    } catch (e) {
      emit(HomeState(
        everythingRequestStatus: RequestStatusEnum.eError,
        errorMessage: e.toString()
      ));
    }
  }

  void callHeadLineEndPoint() async {
    emit(state.copyWith(
      topHeadLineRequestStatus: RequestStatusEnum.eLoading,
      errorMessage: null,
    ));
    String category = state.selectedCategory.name.toLowerCase();
    try {
      final articles = await newsRepository.callHeadLineEndPoint(
        selectedCategory: (state.selectedCategory == CategoriesEnum.eTopNews) ? null : category,
      );
      emit(state.copyWith(
        newsHeadLineArticles: articles,
        topHeadLineRequestStatus: RequestStatusEnum.eLoaded,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        topHeadLineRequestStatus: RequestStatusEnum.eError,
        errorMessage: e.toString(),
      ));
    }
  }

  void changeSelectedCategory(CategoriesEnum category) {
    emit(HomeState(
      selectedCategory: category
    ));
    callHeadLineEndPoint();
  }
}
