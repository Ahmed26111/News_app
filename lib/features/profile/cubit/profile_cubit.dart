import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/data_source/local_data/user_repository.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState()){
    loadSelectedImage();
    loadUsername();
    loadCountryName();
  }

  void loadSelectedImage() {
    final String? imagePath = UserRepository().getCurrentUser()?.image;
    if (imagePath != null) {
      emit(state.copyWith(
        selectedImage: File(imagePath),
      ));
    }
  }

  void loadUsername() {
    emit(state.copyWith(
      username: UserRepository().getCurrentUser()?.name
    ));
  }

  void loadCountryName(){
    emit(state.copyWith(
      countryName: UserRepository().getCurrentUser()?.country
    ));
  }

  void changeCountryName(String name) async {
    emit(state.copyWith(
        countryName: name
    ));
    await UserRepository().updateCurrentUser(country: name);
  }

  Future<void> changeSelectedImage(ImageSource source) async {
    final XFile? imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      emit(state.copyWith(
        selectedImage: File(imageFile.path),
      ));
      _saveImage(imageFile);
    }
  }

  void _saveImage(XFile file) async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File newFile = await File(file.path).copy("${appDirectory.path}/${file.name}");
    await UserRepository().updateCurrentUser(image: newFile.path);
  }
}
