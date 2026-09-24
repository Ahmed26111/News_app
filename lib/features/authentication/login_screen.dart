import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/utils/utility.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/authentication/register_screen.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/data_source/local_data/shared_preferences_manager.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TapGestureRecognizer _signInTapGestureRecognizer;

  bool isLoading = false;
  String ?errorMessage;

  @override
  void initState() {
    super.initState();
    _signInTapGestureRecognizer = TapGestureRecognizer()..onTap = () {
      Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen()));
    };
  }

  @override
  void dispose() {
    super.dispose();
    _signInTapGestureRecognizer.dispose();
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
                             _login();
                          }
                        },
                        child: isLoading ? CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor,) : Text("Sign In"),
                    ),
                    SizedBox(height: AppSizes.h24),
                    Center(
                      child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account ?",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              TextSpan(
                                  text: "  Sign Up",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Theme.of(context).primaryColor,),
                                  recognizer: _signInTapGestureRecognizer,
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

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await Future.delayed(Duration(seconds: 1));

    // final String? email = SharedPreferencesManager().getString(SharedPreferencesKeys.userEmail);
    final String? email = UserRepository().getCurrentUser()?.email;
    // final String? password = SharedPreferencesManager().getString(SharedPreferencesKeys.userPassword);
    final String? password = UserRepository().getCurrentUser()?.password;

    if(email == null || password == null || (email != _emailController.text || password != _passwordController.text) ){
      setState(() {
        isLoading = false;
        errorMessage = "User Not Found";
      });
    }else{
      setState(() {
        isLoading = false;
        errorMessage = null;
      });

      await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, true);

      if(context.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    }
  }

}
