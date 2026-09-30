part of 'profile_cubit.dart';

class ProfileState extends Equatable{
  final File? selectedImage;
  final String? username;
  final String? countryName;

  const ProfileState({
    this.selectedImage,
    this.username,
    this.countryName,
  });

  ProfileState copyWith({
    File? selectedImage,
    String? username,
    String? countryName,
  }) {
    return ProfileState(
      selectedImage: selectedImage ?? this.selectedImage,
      username: username ?? this.username,
      countryName: countryName ?? this.countryName,
    );
  }

  @override
  List<Object?> get props => [selectedImage, username, countryName];
}

