import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/model/user_model.dart';

import '../repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState());

  final AuthRepository _authRepository;

  Future<void> login({required String username , required String password})async{
    emit(state.copyWith(status: RequestStatusEnum.eLoading));
    try{
      await _authRepository.login(username: username, password: password);
      emit(state.copyWith(status: RequestStatusEnum.eLoaded));
    }catch(e){
      emit(state.copyWith(status: RequestStatusEnum.eError , errorMessage: e.toString()));
    }
  }
}
