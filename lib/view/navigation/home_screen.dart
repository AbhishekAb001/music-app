import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/contorller.dart';
import 'package:music/controller/favorite_controller.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/favorite_service.dart';
import 'package:music/view/navigation/music_screen.dart';
import 'package:music/widgets/CarouselSliderEffect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final PageController _pageController = PageController();
  late List<Map<dynamic, dynamic>> carsoulSongs;
  late List<Map<dynamic, dynamic>> oneCategorySongs;
  late List<Map<dynamic, dynamic>> allSongs;

  MusicController musicController = Get.find();
  FavoriteController favoriteController = Get.put(FavoriteController());
  ProfileController profileController = Get.find();
  Contorller contorller = Get.find();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    carsoulSongs = musicController.getPopMusics;
    oneCategorySongs = musicController.getRandomMusics;
    allSongs = musicController.getAllMusic;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.2,
            child: CarouselSliderEffect(carouselSongs: carsoulSongs),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  oneCategorySongs[0]['category'] ?? "Category Name",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: const Color.fromRGBO(255, 46, 0, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    contorller.changeBottomIndex(3);
                  },
                  child: Text(
                    "See category",
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: const Color.fromRGBO(248, 162, 69, 1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHorizontal(),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Songs",
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: const Color.fromRGBO(255, 46, 0, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  _buildAllSongs(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSongs() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allSongs.length,
      itemBuilder: (context, index) {
        bool isFavorite = favoriteController.isFavorite(allSongs[index]["id"]);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MusicPlayerScreen(
                      initialIndex: index,
                      playlist: allSongs,
                    ),
              ),
            );
          },
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.025,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Song Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: MediaQuery.of(context).size.width * 0.23,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(
                          allSongs[index]["url"],
                          fit: BoxFit.cover,
                        ),
                      ),

                      Icon(
                        Icons.play_circle_fill,
                        color: Colors.white.withOpacity(0.5),
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  // Song Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        allSongs[index]["songName"],
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(203, 200, 200, 1),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${allSongs[index]["duration"]} • ",
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: const Color.fromRGBO(132, 125, 125, 1),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            allSongs[index]["artist"],
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: const Color.fromRGBO(132, 125, 125, 1),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  // More Options Button
                  PopupMenuButton<String>(
                    onSelected: (String newValue) {
                      favoriteController.toggleFavorite(
                        profileController.profile["uid"],
                        allSongs[index]["id"],
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    color: Colors.black,
                    itemBuilder:
                        (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'Favorite',
                            child:
                                (isFavorite)
                                    ? Text(
                                      'Remove from Favorite',
                                      style: TextStyle(color: Colors.white),
                                    )
                                    : Text(
                                      'Add to Favorite',
                                      style: TextStyle(color: Colors.white),
                                    ),
                          ),
                        ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHorizontal() {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: oneCategorySongs.length,
        itemBuilder: (context, index) {
          bool isFavorite = favoriteController.isFavorite(
            oneCategorySongs[index]["id"],
          );

          return FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.width * 0.05,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MusicPlayerScreen(
                            initialIndex: index,
                            playlist: oneCategorySongs,
                          ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            oneCategorySongs[index]["url"] ??
                                "https://static.vecteezy.com/system/resources/thumbnails/036/594/092/small_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.width * 0.02,
                            child: GestureDetector(
                              onTap: () {
                                favoriteController.toggleFavorite(
                                  profileController.profile["uid"],
                                  oneCategorySongs[index]["id"],
                                );
                                setState(() {});
                              },
                              child:
                                  (isFavorite)
                                      ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size:
                                            MediaQuery.of(context).size.width *
                                            0.06,
                                      )
                                      : Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.width *
                                            0.06,
                                      ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white.withOpacity(0.5),
                              size: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        oneCategorySongs[index]["songName"] ?? "Unknown Title",
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
