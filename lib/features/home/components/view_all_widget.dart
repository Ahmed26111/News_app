import 'package:flutter/material.dart';

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({super.key, required this.title, this.titleColor, required this.onTap});

  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: titleColor ?? Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              "View all",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: titleColor ?? Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: titleColor ?? Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
