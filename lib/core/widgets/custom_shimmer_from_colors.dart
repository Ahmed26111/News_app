import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerFromColors extends StatelessWidget {
  const CustomShimmerFromColors({super.key, required this.child, this.baseColor, this.highlightColor});

  final Widget child;

  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        child: child,
    );
  }
}
