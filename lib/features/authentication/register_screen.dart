import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/utils/utility.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late final TapGestureRecognizer _signUpTapGestureRecognizer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String ?errorMessage;

  @override
  void initState() {
    super.initState();
    _signUpTapGestureRecognizer = TapGestureRecognizer()..onTap = () {
      Navigator.pop(context);
    };
  }

  @override
  void dispose() {
    super.dispose();
    _signUpTapGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: AppSizes.w375,
            height: AppSizes.h832,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo_image.png",
                        height: AppSizes.h46,
                      ),
                    ),
                    SizedBox(height: AppSizes.h24),
                    Text(
                      "Welcome to News",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppSizes.h16),
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
                    SizedBox(height: AppSizes.h12),
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: "*************",
                      title: "Password",
                      isObscureText: true,
                      validator: _passwordValidator,
                    ),
                    SizedBox(height: AppSizes.h12),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: "*************",
                      title: "Confirm Password",
                      isObscureText: true,
                      validator: _confirmPasswordValidator,
                    ),
                    SizedBox(height: AppSizes.h20),
                    if(errorMessage != null)
                      Padding(
                        padding: EdgeInsets.all(AppSizes.pw12),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    FilledButton(
                      onPressed: () {
                        if(_formKey.currentState?.validate() ?? false){
                          _register();
                        }
                      },
                      child: isLoading ? CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor,) : Text("Sign Up"),
                    ),
                    SizedBox(height: AppSizes.h24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Have an account ?",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            TextSpan(
                              text: "  Sign In",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: Theme.of(context).primaryColor,),
                              recognizer: _signUpTapGestureRecognizer,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  String? _passwordValidator(String? value) {
    if(value == null || value.isEmpty){
      return "Password is required";
    }else if(!Utility.isValidPassword(value)){
      if(!Utility.isContainSpecialCharacter(value)){
        return "Password must contain special character";
      }else if(!Utility.isContainLowerCaseCharacter(value)){
        return "Password must contain lower case character";
      }else if(!Utility.isContainUpperCaseCharacter(value)){
        return "Password must contain upper case character";
      }
      else if(!Utility.isContainDigitCharacter(value)){
        return "Password must contain digit character";
      }else if(!Utility.hasMinLength(value)){
        return "Password must be at least 8 characters long";
      }
      return "Invalid password";
    }else{
      return null;
    }
  }

  String? _confirmPasswordValidator(String? value) {
     if(value != _passwordController.text){
       return "Password does not match";
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

  Future<void> _register() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await Future.delayed(Duration(seconds: 1));

    final String? email = SharedPreferencesManager().getString(SharedPreferencesKeys.userEmail);


    if(email != null && email == _emailController.text){
      setState(() {
        isLoading = false;
        errorMessage = "User Already Exists";
      });
    }
    else{

      await SharedPreferencesManager().setString(SharedPreferencesKeys.userEmail, _emailController.text);
      await SharedPreferencesManager().setString(SharedPreferencesKeys.userPassword, _passwordController.text);
      await SharedPreferencesManager().setString(SharedPreferencesKeys.username, _usernameController.text);
      await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, true);
      await SharedPreferencesManager().remove(SharedPreferencesKeys.imageKey);

      setState(() {
        isLoading = false;
        errorMessage = null;
      });

      if(context.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    }
  }

}
