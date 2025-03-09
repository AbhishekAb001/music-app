import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/controller/categories_controller.dart';
import 'package:music/controller/contorller.dart';
import 'package:music/controller/favorite_controller.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/favorite_service.dart';
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
  final ProfileController profileController = Get.find();
  final MusicController musicController = Get.put(MusicController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  FavoriteController favoriteController = Get.put(FavoriteController());
  final Contorller contorller = Get.put(Contorller());

  final RxBool isLoading = true.obs; // Corrected RxBool usage

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
    _fetchMusicsFromHive();
  }

  void _fetchMusicsFromHive() async {
    try {
      Box box = await Hive.openBox("musics");
      //----------------------------- Profile -----------------------------
      d.log("performing profile fetch");
      Map<dynamic, dynamic> profile = await box.get("user", defaultValue: {});
      profileController.setProfile(profile);

      //----------------------------- Musics -----------------------------
      d.log("performing music fetch");
      List<dynamic> rawData = box.get("musics", defaultValue: []);
      List<Map<String, dynamic>> demo =
          rawData.map((e) => Map<String, dynamic>.from(e)).toList();

      musicController.setMusics(demo);

      //----------------------------- Categories -----------------------------
      d.log("performing category fetch");
      categoriesController.setCategories(
        await box.get("categories", defaultValue: []),
      );

      //----------------------------- Favourites -----------------------------
      d.log("performing favorite fetch");
      final favorite = await FavoriteService().getFavorite(
        profileController.profile["uid"],
      );
      d.log("favorite: $favorite");
      favoriteController.setFavorite(favorite);

      d.log("favorite: $favorite");
      isLoading.value = false;
    } catch (e) {
      d.log("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.shortestSide; // Responsive sizing

    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Obx(
        () =>
            isLoading.value
                ? Center(
                  child: CircularProgressIndicator(
                    color: const Color.fromARGB(255, 171, 58, 58),
                  ),
                )
                : pages[contorller.bottomIndex.value],
      ),

      bottomNavigationBar: Obx(
        () =>
            isLoading.value
                ? const SizedBox()
                : CurvedNavigationBar(
                  index: contorller.bottomIndex.value,
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
                    contorller.changeBottomIndex(index);
                  },
                  letIndexChange: (index) => true,
                ),
      ),

      floatingActionButton: Obx(
        () =>
            (contorller.isPlaying.value)
                ? FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: const Color.fromRGBO(230, 154, 21, 1),
                  onPressed: () {
                    List<Map<dynamic, dynamic>> allMusic =
                        musicController.getAllMusic;
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
                    size: screenWidth * 0.1,
                    color: Colors.white,
                  ),
                )
                : const SizedBox(),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          if (index != contorller.bottomIndex.value) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
