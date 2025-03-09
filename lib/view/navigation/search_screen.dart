import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/music_controller.dart';

class MusicSearchScreen extends StatefulWidget {
  const MusicSearchScreen({super.key});

  @override
  _MusicSearchScreenState createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<dynamic, dynamic>> filteredSongs = [];
  late List<Map<dynamic, dynamic>> musicData = [];
  MusicController musicController = Get.find();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    musicData = musicController.getAllMusic;
  }

  void _filterSongs(String query) {
    setState(() {
      isSearching = true; // Start the searching animation
      filteredSongs =
          musicData
              .where(
                (song) =>
                    song['songName'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    song['category'].toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
      isSearching = false; // End the searching animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: Text(
          "Search Music",
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterSongs,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search by song name or category...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: isSearching ? 0.5 : 1.0,
              duration: const Duration(milliseconds: 500),
              child:
                  filteredSongs.isEmpty
                      ? const Center(
                        child: Text(
                          "No songs found",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          var song = filteredSongs[index];
                          return Card(
                            color: Colors.black,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Image.network(
                                song['url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                song['songName'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                "${song['category']} • ${song['duration']}",
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Handle song play
                                },
                              ),
                              onTap: () {
                                // Handle song selection
                              },
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
