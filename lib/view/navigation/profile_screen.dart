import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/categories_controller.dart';
import 'package:music/controller/favorite_controller.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/shered_prefrence_service.dart';
import 'package:music/view/users/login_screen.dart';

class MusicProfileScreen extends StatelessWidget {
  MusicProfileScreen({super.key});

  final ProfileController controller = Get.find();
  final MusicController musicController = Get.put(MusicController());
  final CategoriesController categoriesController = Get.put(
    CategoriesController(),
  );
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.deepPurple.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    SharedPreferenceService.setLoginPref("", false);
                    Get.offAll(LoginScreen());
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundImage: AssetImage("assets/avatar.jpg"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                Text(
                  controller.profile['name'] ?? "Artist Name",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileStat(
                        title: "Albums",
                        value:
                            categoriesController.categories.length.toString(),
                      ),
                      ProfileStat(
                        title: "Favorites",
                        value:
                            favoriteController.favoriteData.length.toString(),
                      ),
                      ProfileStat(
                        title: "Songs",
                        value: musicController.getAllMusic.length.toString(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                MusicVisualizer(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "About",
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "A passionate music artist bringing soulful melodies and energetic beats to fans worldwide.",
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.logout, color: Colors.white, size: 30),
              onPressed: () {
                SharedPreferenceService.setLoginPref("", false);
                Get.offAll(LoginScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const ProfileStat({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class MusicVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 400 + index * 100),
          height: MediaQuery.of(context).size.width * (0.05 + index * 0.01),
          width: MediaQuery.of(context).size.width * 0.02,
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
