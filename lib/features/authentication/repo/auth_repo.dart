import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/data_source/remote_data/auth/auth_api_service.dart';

import '../../../core/data_source/remote_data/auth/auth_api_configuration.dart';
import '../../../core/model/user_model.dart';

class AuthRepository {
  const AuthRepository({required this.apiService});

  final AuthBaseApiService apiService;

  Future<UserModel> login({required String username, required String password}) async {
    try {
      final data = await apiService.post(
        endPoint: AuthApiConfiguration.loginEndPoint,
        body: {"username": username, "password": password},
      );

      final model = UserModel.fromAuthResponse(data);

      await UserRepository().updateUser(model);


      return model;
    } catch (e) {
      rethrow;
    }
  }
}
