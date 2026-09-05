import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.isObscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final String? Function(String?)? validator;
  final bool isObscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: AppSizes.h8),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: (widget.isObscureText)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      (isVisible) ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
          obscureText: widget.isObscureText && !isVisible,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
