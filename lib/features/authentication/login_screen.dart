import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/utils/utility.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/authentication/cubit/auth_cubit.dart';
import 'package:news_app/features/authentication/register_screen.dart';
import 'package:news_app/features/authentication/repo/auth_repo.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/local_data/shared_preferences_keys.dart';
import '../../core/data_source/local_data/shared_preferences_manager.dart';
import '../../core/data_source/remote_data/api_service.dart';
import '../../core/enum/request_status_enum.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TapGestureRecognizer _signInTapGestureRecognizer;

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _signInTapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
              image: DecorationImage(image: AssetImage("assets/images/background_image.png"), fit: BoxFit.fill),
            ),
            child: BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(AuthRepository(apiService: ApiService())),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset("assets/images/logo_image.png", height: AppSizes.h46)),
                          SizedBox(height: AppSizes.h24),
                          Text("Welcome to News", style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: AppSizes.h16),
                          CustomTextFormField(
                            controller: _usernameController,
                            hintText: "usama",
                            title: "Username",
                            // validator: _emailValidator,
                          ),
                          SizedBox(height: AppSizes.h12),
                          CustomTextFormField(
                            controller: _passwordController,
                            hintText: "*************",
                            title: "Password",
                            isObscureText: true,
                            // validator: _passwordValidator,
                          ),
                          SizedBox(height: AppSizes.h20),
                          if (state.status == RequestStatusEnum.eError)
                            Padding(
                              padding: EdgeInsets.all(AppSizes.pw12),
                              child: Text(state.errorMessage!, style: TextStyle(color: Colors.red)),
                            ),
                          FilledButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await context.read<AuthCubit>().login(username: _usernameController.text, password: _passwordController.text);
                              }
                            },
                            child: state.status == RequestStatusEnum.eLoading
                                ? CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor)
                                : Text("Sign In"),
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.copyWith(color: Theme.of(context).primaryColor),
                                    recognizer: _signInTapGestureRecognizer,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // String? _emailValidator(String? value) {
  //   if(value == null || value.isEmpty){
  //     return "Email is required";
  //   }else if(!Utility.isValidEmail(value)){
  //     return "Invalid email";
  //   }else{
  //     return null;
  //   }
  // }

  // String? _passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Password is required";
  //   } else if (!Utility.isValidPassword(value)) {
  //     if (!Utility.isContainSpecialCharacter(value)) {
  //       return "Password must contain special character";
  //     } else if (!Utility.isContainLowerCaseCharacter(value)) {
  //       return "Password must contain lower case character";
  //     } else if (!Utility.isContainUpperCaseCharacter(value)) {
  //       return "Password must contain upper case character";
  //     } else if (!Utility.isContainDigitCharacter(value)) {
  //       return "Password must contain digit character";
  //     } else if (!Utility.hasMinLength(value)) {
  //       return "Password must be at least 8 characters long";
  //     }
  //     return "Invalid password";
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> _login() async {
  //   setState(() {
  //     isLoading = true;
  //     errorMessage = null;
  //   });
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   final String? error = UserRepository().login(email: _emailController.text, password: _passwordController.text);
  //
  //   if(error != null){
  //     setState(() {
  //       isLoading = false;
  //       errorMessage = error;
  //     });
  //   }else{
  //     setState(() {
  //       isLoading = false;
  //       errorMessage = null;
  //     });
  //
  //     await SharedPreferencesManager().setBool(SharedPreferencesKeys.loginCompleted, true);
  //
  //     if(context.mounted){
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  //     }
  //   }
  // }
}
