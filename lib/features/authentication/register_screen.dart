import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_text_form_field.dart';

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
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "*************",
                  title: "Password",
                  isObscureText: true,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: "*************",
                  title: "Confirm Password",
                  isObscureText: true,
                ),
                SizedBox(height: 20),
                FilledButton(
                  onPressed: () {},
                  child: Text("Sign Up"),
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
    );
  }

}
