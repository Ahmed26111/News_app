import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/request_status_enum.dart';
import '../../../core/model/news_article_model.dart';
import '../../../core/repos/news_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(SearchState()){
    callEverythingEndPoint();
  }

  final BaseNewsRepository newsRepository;
  final TextEditingController searchController = TextEditingController();

  void callEverythingEndPoint() async {
    emit(SearchState(
      everythingRequestStatus: RequestStatusEnum.eLoading,
      errorMessage: null,
    ));
    try {
      final newsEveryThingArticles = (searchController.text.isEmpty)
          ? await newsRepository.callEverythingEndPoint()
          : await newsRepository.callEverythingEndPoint(query: searchController.text);
      emit(SearchState(
        everythingRequestStatus: RequestStatusEnum.eLoaded,
        errorMessage: null,
        newsEveryThingArticles: newsEveryThingArticles,
      ));
    } catch (e) {
      emit(SearchState(
        everythingRequestStatus: RequestStatusEnum.eError,
        errorMessage: e.toString(),
      ));
    }
  }

}
