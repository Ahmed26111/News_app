import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/light_color_constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, this.borderRadius, this.onChanged});

  final TextEditingController controller;
  final double? borderRadius;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(
              color: LightColorConstant.secondBorderColor,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(
              color: LightColorConstant.secondBorderColor,
            )
        ),
        suffixIcon: Icon(
          Icons.search,
          color: Theme.of(context).textTheme.bodySmall?.color,
          size: AppSizes.r30,
        ),
      ),
    );
  }
}
