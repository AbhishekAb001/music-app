import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:music/view/navigation/category_screen.dart';
import 'package:music/view/navigation/home_screen.dart';
import 'package:music/view/navigation/music_screen.dart';
import 'package:music/view/navigation/profile_screen.dart';
import 'package:music/view/navigation/search_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentPage = 2;
  final List<Widget> pages = [
    HomeScreen(),
    MusicSearchScreen(),
    HomeScreen(),
    MusicCategoryScreen(),
    MusicProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: pages[currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentPage,
        height: 70.0, // Adjust height to accommodate labels
        items: <Widget>[
          _buildNavItem(0, Icons.favorite_border, "Favourites"),
          _buildNavItem(1, Icons.search, "Search"),
          _buildNavItem(2, Icons.home_outlined, "Home"),
          _buildNavItem(3, Icons.category_outlined, "Categories"),
          _buildNavItem(4, Icons.person_outline, "Profile"),
        ],
        color: const Color.fromRGBO(19, 19, 19, 1),
        buttonBackgroundColor: const Color.fromRGBO(230, 154, 21, 1),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.white),
        if (index != currentPage) ...[
          const SizedBox(height: 4), // Space between icon and label
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
