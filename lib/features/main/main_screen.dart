import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_screen.dart';

import '../bookmark/bookmark_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _screens = const[
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  int _selectedScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: (index)=> setState(()=> _selectedScreenIndex = index),
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: "Bookmark"),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile"),
          ],
      ),
    );
  }
}
