import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';

import '../../../core/data_source/remote_data/api_configuration.dart';
import '../../../core/model/user_model.dart';

class AuthRepository {
  const AuthRepository({required this.apiService});

  final BaseApiService apiService;

  Future<UserModel> login({required String username, required String password}) async {
    try {
      final data = await apiService.post(
        baseUrl: ApiConfiguration.dummyBaseUrl,
        endPoint: ApiConfiguration.loginEndPoint,
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
