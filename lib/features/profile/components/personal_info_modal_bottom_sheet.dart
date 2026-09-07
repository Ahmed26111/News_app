import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color_constant.dart';

import '../../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../../core/utils/utility.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class PersonalInfoModalBottomSheet extends StatefulWidget {
  const PersonalInfoModalBottomSheet({super.key});

  @override
  State<PersonalInfoModalBottomSheet> createState() => _PersonalInfoModalBottomSheetState();
}

class _PersonalInfoModalBottomSheetState extends State<PersonalInfoModalBottomSheet> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController.text = SharedPreferencesManager().getString(SharedPreferencesKeys.username) ?? "";
    _emailController.text = SharedPreferencesManager().getString(SharedPreferencesKeys.userEmail) ?? "";
  }

  void _saveUserData(){
    if(_formKey.currentState?.validate() ?? false){
      SharedPreferencesManager().setString(SharedPreferencesKeys.username, _usernameController.text);
      SharedPreferencesManager().setString(SharedPreferencesKeys.userEmail, _emailController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r16)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.h16,),
                Center(
                  child: SizedBox(
                    height: AppSizes.h4,
                    width: AppSizes.w32,
                    child: Divider(
                      color: LightColorConstant.textSecondaryColor,
                      radius: BorderRadius.circular(AppSizes.r100),
                      thickness: 4,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h32,),
                Text("Profile Info", style: Theme.of(context).textTheme.labelSmall),
                SizedBox(height: AppSizes.h24),
                CustomTextFormField(
                  controller: _usernameController,
                  hintText: "e.g. Sarah Khalid",
                  title: "Username",
                  validator: _usernameValidator,
                ),
                SizedBox(height: AppSizes.h12),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "usama@gmail.com",
                  title: "Email",
                  validator: _emailValidator,
                ),
                SizedBox(height: AppSizes.h24),
                FilledButton(
                    onPressed: (){
                      _saveUserData();
                    },
                    child: Text("Save")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if(value == null || value.isEmpty){
      return "Email is required";
    }else if(!Utility.isValidEmail(value)){
      return "Invalid email";
    }else{
      return null;
    }
  }

  String? _usernameValidator(String? value) {
    if(value == null || value.trim().isEmpty){
      return "Username is required";
    }else{
      return null;
    }
  }
}
