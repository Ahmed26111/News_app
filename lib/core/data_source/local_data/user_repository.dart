import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/hive_constants.dart';

import '../../model/user_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() => _instance;

  late final Box<UserModel> _userBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    _userBox = await Hive.openBox<UserModel>(HiveConstants.usersBoxKey);
  }

  Future<void> updateCurrentUser({String? name, String? email, String? password, String? country, String? image}) async {
    UserModel? user = getCurrentUser();
    if (user == null) {
      user = UserModel(
        name: name ?? '',
        email: email ?? '',
        password: password ?? '',
        country: country,
        image: image,
      );
    } else {
      user = user.copyWith(
        name: name,
        email: email,
        password: password,
        country: country,
        image: image,
      );
    }
    await _userBox.put(HiveConstants.currentUserKey, user);
  }

  Future<void> removeCurrentUser() async {
    await _userBox.delete(HiveConstants.currentUserKey);
  }

  Future<void> addCurrentUser({
    required String name,
    required String email,
    required String password,
    String? country,
    String? image,
  }) async {
    await updateCurrentUser(
      name: name,
      email: email,
      password: password,
      country: country,
      image: image,
    );
  }

  UserModel? getCurrentUser() {
    return _userBox.get(HiveConstants.currentUserKey);
  }
}
