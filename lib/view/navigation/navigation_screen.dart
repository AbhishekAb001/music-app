import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/music_service.dart';
import 'package:music/view/navigation/category_screen.dart';
import 'package:music/view/navigation/faveroite_screen.dart';
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
  ProfileController profileController = Get.find();
  MusicController musicController = Get.put(MusicController());
  int currentPage = 2;
  bool isLoading = false;
  final List<Widget> pages = [
    FavoriteMusicScreen(),
    MusicSearchScreen(),
    HomeScreen(),
    MusicCategoryScreen(),
    MusicProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _fetchMusicsFromHive();
  }

  void _fetchMusicsFromHive() async {
    try {
      Box box = await Hive.openBox("musics");
      List<dynamic> rawData = box.get("musics", defaultValue: []);
      List<Map<String, dynamic>> demo =
          rawData.map((e) => Map<String, dynamic>.from(e)).toList();

      musicController.setMusics(demo);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      d.log("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body:
          (isLoading)
              ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: const Color.fromARGB(255, 171, 58, 58),
                  size: MediaQuery.of(context).size.width * 0.2,
                ),
              )
              : pages[currentPage],
      bottomNavigationBar:
          (isLoading)
              ? const SizedBox()
              : CurvedNavigationBar(
                index: currentPage,
                height: 70.0,
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color.fromRGBO(230, 154, 21, 1),
        onPressed: () {
          List<Map<dynamic, dynamic>> allMusic = musicController.getAllMusic;
          Get.to(
            MusicPlayerScreen(
              initialIndex: Random().nextInt(allMusic.length),
              playlist: allMusic,
            ),
            transition: Transition.downToUp,
          );
        },
        child: Icon(
          Icons.play_arrow,
          size: MediaQuery.of(context).size.width * 0.1,
          color: Colors.white,
        ),
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
