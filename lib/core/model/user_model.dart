import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String? country;
  @HiveField(4)
  final String? image;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.country,
    this.image,
  });

  Map<String, dynamic> toMap({
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return {
      keyMapper('name'): this.name,
      keyMapper('email'): this.email,
      keyMapper('password'): this.password,
      keyMapper('country'): this.country,
      keyMapper('image'): this.image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {
    String Function(String key)? keyMapper,
  }) {
    keyMapper ??= (key) => key;

    return UserModel(
      name: map[keyMapper('name')] as String,
      email: map[keyMapper('email')] as String,
      password: map[keyMapper('password')] as String,
      country: map[keyMapper('country')] as String?,
      image: map[keyMapper('image')] as String?,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? country,
    String? image,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      country: country ?? this.country,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, country: $country, image: $image}';
  }
}
