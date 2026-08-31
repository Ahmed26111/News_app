import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  controller: emailController,
                  hintText: "usama@gmail.com",
                  title: "Email",
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "*************",
                  title: "Password",
                  isObscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
