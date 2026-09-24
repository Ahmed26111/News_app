import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/mixins/safe_notif'
    'ier_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifier {
  File? selectedImage;
  String? username;
  String? countryName;


  ProfileController() {
    loadSelectedImage();
    loadUsername();
    loadCountryName();
  }

  void loadSelectedImage() {
    final String? imagePath = UserRepository().getCurrentUser()?.image;
    if (imagePath != null) {
      selectedImage = File(imagePath);
    }
  }

  void loadUsername() {
    username = UserRepository().getCurrentUser()?.name;
    notifyListeners();
  }

  void loadCountryName(){
    countryName = UserRepository().getCurrentUser()?.country;
  }

  void changeCountryName(String name) async {
    countryName = name;
    await UserRepository().updateCurrentUser(country: name);
    notifyListeners();
  }

  Future<void> changeSelectedImage(ImageSource source) async {
    final XFile? imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      selectedImage = File(imageFile.path);
      _saveImage(imageFile);
      notifyListeners();
    }
  }

  void _saveImage(XFile file) async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File newFile = await File(file.path).copy("${appDirectory.path}/${file.name}");
    await UserRepository().updateCurrentUser(image: newFile.path);
  }
}
