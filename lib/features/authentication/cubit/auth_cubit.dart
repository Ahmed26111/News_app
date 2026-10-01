import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/model/user_model.dart';

import '../../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../../core/data_source/local_data/user_repository.dart';
import '../repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState());

  final AuthRepository _authRepository;

  Future<void> login({required String username , required String password})async{
    emit(state.copyWith(status: RequestStatusEnum.eLoading , errorMessage: null));
    try{
      final userModel = await _authRepository.login(username: username, password: password);
      emit(state.copyWith(status: RequestStatusEnum.eLoaded , user: userModel , errorMessage: null));
    }catch(e){
      emit(state.copyWith(status: RequestStatusEnum.eError , errorMessage: e.toString()));
    }
  }

  Future<void> register({required String name , required String email , required String password}) async {
    emit(state.copyWith(status: RequestStatusEnum.eLoading , errorMessage: null));

    await Future.delayed(Duration(seconds: 1));

    final String? error = await UserRepository().signUp(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      emit(state.copyWith(status: RequestStatusEnum.eError , errorMessage: error));
    } else {
      await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, true);

      emit(state.copyWith(status: RequestStatusEnum.eLoaded , errorMessage: null));
    }
  }
}
