import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16 , vertical: AppSizes.ph20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                suffixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    size: AppSizes.r30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
