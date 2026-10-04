import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? country;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String? accessToken;
  @HiveField(6)
  final String? refreshToken;


  UserModel({
    required this.name,
    this.email,
    this.password,
    this.country,
    this.image,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toMap({
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return {
      keyMapper('name'): name,
      keyMapper('email'): email,
      keyMapper('password'): password,
      keyMapper('country'): country,
      keyMapper('image'): image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return UserModel(
      name: map[keyMapper('name')] as String,
      email: map[keyMapper('email')] as String?,
      password: map[keyMapper('password')] as String?,
      country: map[keyMapper('country')] as String?,
      image: map[keyMapper('image')] as String?,
    );
  }

  factory UserModel.fromAuthResponse(Map<String, dynamic> json){
    return UserModel(
      name: json["username"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"]
    );
  }


  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? country,
    String? image,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      country: country ?? this.country,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, country: $country, image: $image , accessToken: $accessToken , refreshToken: $refreshToken}';
  }
}
