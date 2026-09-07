import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../core/mixins/safe_notifier_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifier {
  File? selectedImage;
  String? username;

  ProfileController() {
    loadSelectedImage();
    loadUsername();
  }

  void loadSelectedImage() {
    final String? imagePath = SharedPreferencesManager().getString(SharedPreferencesKeys.imageKey);
    if (imagePath != null) {
      selectedImage = File(imagePath);
    }
  }

  void loadUsername() {
    username = SharedPreferencesManager().getString(SharedPreferencesKeys.username);
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
    await SharedPreferencesManager().setString(SharedPreferencesKeys.imageKey, newFile.path);
  }
}
