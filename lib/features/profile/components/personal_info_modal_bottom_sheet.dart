import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
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
    _usernameController.text = UserRepository().getCurrentUser()?.name ?? "";
    _emailController.text = UserRepository().getCurrentUser()?.email ?? "";
  }

  Future<void> _saveUserData() async {
    if(_formKey.currentState?.validate() ?? false){
      await UserRepository().updateCurrentUser(
        name: _usernameController.text,
        email: _emailController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: AppSizes.h16,),
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
                  SizedBox(height: AppSizes.h24),
                ],
              ),
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
