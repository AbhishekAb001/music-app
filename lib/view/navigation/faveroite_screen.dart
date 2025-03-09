import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/favorite_controller.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/controller/peofile_controller.dart';

class FavoriteMusicScreen extends StatefulWidget {
  const FavoriteMusicScreen({super.key});

  @override
  _FavoriteMusicScreenState createState() => _FavoriteMusicScreenState();
}

class _FavoriteMusicScreenState extends State<FavoriteMusicScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());
  MusicController musicController = Get.find();
  ProfileController profileController = Get.find();

  String _sortOption = 'Song Name';
  bool _isAscending = true;

  void _sortSongs() {
    favoriteController.favoriteData.sort((a, b) {
      int cmp;
      if (_sortOption == 'Song Name') {
        cmp = a['songName'].compareTo(b['songName']);
      } else {
        cmp = a['artist'].compareTo(b['artist']);
      }
      return _isAscending ? cmp : -cmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double titleFontSize = screenWidth > 600 ? 24 : 18;
    double iconSize = screenWidth > 600 ? 28 : 20;
    double avatarRadius = screenWidth > 600 ? 30 : 25;
    double cardMargin = screenWidth > 600 ? 12 : 8;
    double paddingValue = screenWidth > 600 ? 20 : 15;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Favorites",
              style: GoogleFonts.inter(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: _sortOption,
                    style: const TextStyle(color: Colors.white),
                    icon: Icon(Icons.sort, color: Colors.white, size: iconSize),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _sortOption = newValue;
                          _sortSongs();
                        });
                      }
                    },
                    items:
                        ['Song Name', 'Artist'].map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _isAscending = !_isAscending;
                      _sortSongs();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(() {
        final favoriteSongs = favoriteController.favoriteData;

        return favoriteSongs.isEmpty
            ? Center(
              child: Text(
                "No favorite songs yet",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: titleFontSize,
                ),
              ),
            )
            : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                final song = favoriteSongs[index];
                return Card(
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(
                    vertical: cardMargin,
                    horizontal: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: NetworkImage(song['url']),
                    ),
                    title: Text(
                      song['songName'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth > 600 ? 18 : 16,
                      ),
                    ),
                    subtitle: Text(
                      song['artist'],
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: screenWidth > 600 ? 16 : 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        favoriteController.favorite.contains(song['id'])
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: iconSize,
                      ),
                      onPressed: () {
                        log("Toggling favorite: ${song['id']}");
                        log(profileController.profile["uid"].toString());
                        favoriteController.toggleFavorite(
                          profileController.profile["uid"],
                          song['id'],
                        );
                      },
                    ),
                  ),
                );
              },
            );
      }),
    );
  }
}
