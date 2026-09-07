import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';
import 'package:news_app/core/theme/light_color_constant.dart';
import 'package:news_app/core/widgets/custom_svg_picture_asset.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../authentication/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Consumer<ProfileController>(
          builder: (BuildContext context, ProfileController controller, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.h28),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: (controller.selectedImage == null)
                              ? AssetImage("assets/images/profile.png")
                              : FileImage(controller.selectedImage!),
                          radius: AppSizes.r60,
                          backgroundColor: Colors.transparent,
                        ),
                        Positioned(
                          right: 0,
                          bottom: -AppSizes.ph3,
                          child: IconButton.filled(
                            onPressed: () {
                              _showImageSourceDialog(context);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: LightColorConstant.inputDecorationFillColor,
                              foregroundColor: LightColorConstant.textPrimaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r30)),
                              side: BorderSide(color: LightColorConstant.borderColor, width: 1),
                            ),
                            icon: Icon(Icons.camera_alt_outlined, size: AppSizes.r25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.h4),
                  Center(
                    child: Text(controller.userEmail ?? "Unknown User", style: Theme.of(context).textTheme.labelLarge),
                  ),
                  SizedBox(height: AppSizes.h16),
                  Text("Profile Info", style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: AppSizes.h8),
                  ..._buildListTile(
                    context: context,
                    leadingIconPath: "assets/images/person_Icon.svg",
                    title: "Personal Info",
                    onTap: () {},
                  ),
                  ..._buildListTile(
                    context: context,
                    leadingIconPath: "assets/images/Language_Icon.svg",
                    title: "Language",
                    onTap: () {},
                  ),
                  ..._buildListTile(
                      context: context,
                      leadingIconPath: "assets/images/Country_Icon.svg",
                      title: "Country",
                      onTap: () {},
                  ),
                  ..._buildListTile(
                    context: context,
                    leadingIconPath: "assets/images/terms_condition_Icon.svg",
                    title: "Terms & Conditions",
                    onTap: () {},
                  ),
                  ..._buildListTile(
                    context: context,
                    leadingIconPath: "assets/images/Logout_news_Icon.svg",
                    title: "Logout",
                    onTap: () async {
                      await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted , false);
                      await SharedPreferencesManager().remove(SharedPreferencesKeys.imageKey);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()
                          ),
                      );
                    },
                    isLastTile: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildListTile({
    required String leadingIconPath,
    required String title,
    required VoidCallback onTap,
    bool isLastTile = false,
    required BuildContext context,
  }) {
    return [
      ListTile(
        onTap: onTap,
        leading: CustomSvgPictureAsset(path: leadingIconPath),
        title: Text(title, style: (isLastTile) ? Theme.of(context).textTheme.titleSmall : null),
        trailing: (isLastTile)
            ? CustomSvgPictureAsset.withColorFilter(
                path: "assets/images/forward_Icon.svg",
                color: LightColorConstant.primaryColor,
              )
            : CustomSvgPictureAsset(path: "assets/images/forward_Icon.svg"),
      ),
      if (!isLastTile) Divider(),
    ];
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Choose Image Source"),
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await context.read<ProfileController>().changeSelectedImage(ImageSource.camera);
            },
            child: Row(
              children: [
                const Icon(Icons.camera_alt_rounded),
                SizedBox(width: AppSizes.w8),
                const Text("Camera"),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await context.read<ProfileController>().changeSelectedImage(ImageSource.gallery);
            },
            child: Row(
              children: [
                const Icon(Icons.photo_library),
                SizedBox(width: AppSizes.w8),
                const Text("Gallery"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
