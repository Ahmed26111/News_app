import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/shared_preferences_manager.dart';

import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/utils/validation.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo_image.png",
                      height: 46,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Welcome to News",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "usama@gmail.com",
                    title: "Email",
                    validator: _emailValidator,
                  ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: "*************",
                    title: "Password",
                    isObscureText: true,
                    validator: _passwordValidator,
                  ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: "*************",
                    title: "Confirm Password",
                    isObscureText: true,
                    validator: _passwordValidator,
                  ),
                  SizedBox(height: 20),
                  if(errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(12),
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
                  SizedBox(height: 24),
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
    );
  }
  String? _emailValidator(String? value) {
    if(value == null || value.isEmpty){
      return "Email is required";
    }else if(!Validation.isValidEmail(value)){
      return "Invalid email";
    }else{
      return null;
    }
  }

  String? _passwordValidator(String? value) {
    if(value == null || value.isEmpty){
      return "Password is required";
    }else if(!Validation.isValidPassword(value)){
      if(!Validation.isContainSpecialCharacter(value)){
        return "Password must contain special character";
      }else if(!Validation.isContainLowerCaseCharacter(value)){
        return "Password must contain lower case character";
      }else if(!Validation.isContainUpperCaseCharacter(value)){
        return "Password must contain upper case character";
      }
      else if(!Validation.isContainDigitCharacter(value)){
        return "Password must contain digit character";
      }else if(!Validation.hasMinLength(value)){
        return "Password must be at least 8 characters long";
      }
      return "Invalid password";
    }else{
      return null;
    }
  }

  Future<void> _register() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await Future.delayed(Duration(seconds: 3));

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
      await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, true);

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
