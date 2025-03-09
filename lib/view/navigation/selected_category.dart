import 'dart:developer' as d;
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/favorite_controller.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';

import 'package:music/view/navigation/music_screen.dart';

class SelectedCategory extends StatefulWidget {
  final String category;
  final String url;

  const SelectedCategory({
    super.key,
    required this.category,
    required this.url,
  });

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  MusicController musicController = Get.find();
  List<Map<dynamic, dynamic>> musicItems = [];

  @override
  void initState() {
    super.initState();
    musicItems = musicController.getMusicByCategory(widget.category);
    d.log(musicItems.toString());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    FavoriteController favoriteController = Get.find();
    ProfileController profileController = Get.find();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Image at the top
          Positioned(
            top: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight / 3,
              child: Stack(
                children: [
                  Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.03,
                      bottom: screenHeight * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                            ),
                            Text(
                              widget.category,
                              style: GoogleFonts.roboto(
                                fontSize: screenWidth * 0.055,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AnimatedContainer below the image
          Positioned(
            top: screenHeight / 3.5,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: screenWidth,
              height:
                  screenHeight -
                  (screenHeight / 3) -
                  MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
                color: Color.fromRGBO(19, 19, 19, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.1),
                  topRight: Radius.circular(screenWidth * 0.1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Music List',
                      style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: musicItems.length,
                        itemBuilder: (context, index) {
                          bool isFavorite = favoriteController.isFavorite(
                            musicItems[index]["id"],
                          );
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                MusicPlayerScreen(
                                  initialIndex: index,
                                  playlist: musicItems,
                                ),
                                transition: Transition.downToUp,
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.only(
                                bottom: screenWidth * 0.02,
                              ),
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.15,
                                    height: screenWidth * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          musicItems[index]["url"]!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.08),

                                  // Song Name & Artist (Column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.45,
                                        child: Text(
                                          musicItems[index]["songName"] ??
                                              "Unknown",
                                          style: GoogleFonts.roboto(
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  musicItems[index]["duration"] ??
                                                  "0:00",
                                              style: GoogleFonts.roboto(
                                                fontSize: screenWidth * 0.03,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " | ",
                                              style: GoogleFonts.roboto(
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  musicItems[index]["artist"] ??
                                                  "Unknown",
                                              style: GoogleFonts.roboto(
                                                fontSize: screenWidth * 0.035,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      d.log(
                                        "Id :${profileController.profile["uid"]}",
                                      );
                                      d.log("Id :${musicItems[index]["id"]}");
                                      favoriteController.toggleFavorite(
                                        profileController.profile["uid"],
                                        musicItems[index]["id"],
                                      );
                                      setState(() {});
                                    },
                                    icon:
                                        (isFavorite)
                                            ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                            : Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: screenWidth * 0.04,
            top: screenHeight / 3.3 - screenWidth * 0.1,
            child: GestureDetector(
              onTap: () {
                Get.to(
                  MusicPlayerScreen(
                    initialIndex: Random().nextInt(musicItems.length),
                    playlist: musicItems,
                  ),
                  transition: Transition.downToUp,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: Icon(
                Icons.play_circle_fill,
                color: const Color.fromRGBO(255, 46, 0, 1),
                size: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
