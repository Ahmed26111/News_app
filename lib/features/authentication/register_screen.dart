import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/authentication/cubit/auth_cubit.dart';
import 'package:news_app/features/authentication/repo/auth_repo.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/remote_data/api_service.dart';
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

  @override
  void initState() {
    super.initState();
    _signUpTapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
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
              image: DecorationImage(image: AssetImage("assets/images/background_image.png"), fit: BoxFit.fill),
            ),
            child: BlocProvider<AuthCubit>(
              create: (BuildContext context) => AuthCubit(AuthRepository(apiService: ApiService())),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == RequestStatusEnum.eLoaded) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                  }
                },
                child: Padding(
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
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state.status == RequestStatusEnum.eError) {
                              return Padding(
                                padding: EdgeInsets.all(AppSizes.pw12),
                                child: Text(state.errorMessage!, style: TextStyle(color: Colors.red)),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return FilledButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<AuthCubit>().register(
                                    name: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              },
                              child: state.status == RequestStatusEnum.eLoading
                                  ? CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor)
                                  : Text("Sign Up"),
                            );
                          },
                        ),
                        SizedBox(height: AppSizes.h24),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Have an account ?", style: Theme.of(context).textTheme.labelSmall),
                                TextSpan(
                                  text: "  Sign In",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(color: Theme.of(context).primaryColor),
                                  recognizer: _signUpTapGestureRecognizer,
                                ),
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
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!Utility.isValidEmail(value)) {
      return "Invalid email";
    } else {
      return null;
    }
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (!Utility.isValidPassword(value)) {
      if (!Utility.isContainSpecialCharacter(value)) {
        return "Password must contain special character";
      } else if (!Utility.isContainLowerCaseCharacter(value)) {
        return "Password must contain lower case character";
      } else if (!Utility.isContainUpperCaseCharacter(value)) {
        return "Password must contain upper case character";
      } else if (!Utility.isContainDigitCharacter(value)) {
        return "Password must contain digit character";
      } else if (!Utility.hasMinLength(value)) {
        return "Password must be at least 8 characters long";
      }
      return "Invalid password";
    } else {
      return null;
    }
  }

  String? _confirmPasswordValidator(String? value) {
    if (value != _passwordController.text) {
      return "Password does not match";
    } else {
      return null;
    }
  }

  String? _usernameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    } else {
      return null;
    }
  }
}
