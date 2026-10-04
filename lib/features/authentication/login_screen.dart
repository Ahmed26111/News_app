import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/authentication/cubit/auth_cubit.dart';
import 'package:news_app/features/authentication/register_screen.dart';
import 'package:news_app/features/authentication/repo/auth_repo.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/data_source/remote_data/auth/auth_api_service.dart';
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
              create: (context) => AuthCubit(AuthRepository(apiService: AuthApiService())),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context , state){
                  if(state.status == RequestStatusEnum.eLoaded){
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
                          hintText: "usama",
                          title: "Username",
                        ),
                        SizedBox(height: AppSizes.h12),
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "*************",
                          title: "Password",
                          isObscureText: true,
                        ),
                        SizedBox(height: AppSizes.h20),
                        BlocBuilder<AuthCubit, AuthState>(
                            builder: (context ,state){
                              if (state.status == RequestStatusEnum.eError){
                                return Padding(
                                  padding: EdgeInsets.all(AppSizes.pw12),
                                  child: Text(state.errorMessage!, style: TextStyle(color: Colors.red)),
                                );
                              }
                              return SizedBox();
                            }
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return FilledButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  await context.read<AuthCubit>().login(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              },
                              child: state.status == RequestStatusEnum.eLoading
                                  ? CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor)
                                  : Text("Sign In"),
                            );
                          },
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
