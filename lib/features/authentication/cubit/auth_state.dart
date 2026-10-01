part of 'auth_cubit.dart';

class AuthState extends Equatable{
  const AuthState({this.status = RequestStatusEnum.eInitial, this.user, this.errorMessage});

  final RequestStatusEnum status;
  final UserModel? user;
  final String? errorMessage;

  AuthState copyWith({
    RequestStatusEnum? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}

