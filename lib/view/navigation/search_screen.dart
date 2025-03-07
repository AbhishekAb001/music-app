import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicSearchScreen extends StatefulWidget {
  const MusicSearchScreen({super.key});

  @override
  _MusicSearchScreenState createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredSongs = List.from(musicData);

  void _filterSongs(String query) {
    setState(() {
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
        ],
      ),
    );
  }
}

// Sample Music Data
List<Map<String, dynamic>> musicData = [
  {
    "songName": "Agar Tum Saath Ho - Tamasha",
    "duration": "5:41",
    "fileUrl":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/music%2FSad%2FAgar%20Tum%20Saath%20Ho%20-%20Tamasha%20128%20Kbps.mp3?alt=media",
    "category": "Sad",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/musicImages%2F1741278896258.jpg?alt=media",
  },
  {
    "songName": "Bhula Dena - Aashiqui 2",
    "duration": "4:00",
    "fileUrl":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/music%2FSad%2FBhula%20Dena%20-%20Aashiqui%202%20128%20Kbps.mp3?alt=media",
    "category": "Sad",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/musicImages%2F1741278892269.jpg?alt=media",
  },
  {
    "songName": "Alan Walker - Faded",
    "duration": "3:32",
    "fileUrl":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/music%2FPop%2FAlan_Walker_-_Faded.mp3?alt=media",
    "category": "Pop",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/musicImages%2F1741277677564.jpg?alt=media",
  },
  {
    "songName": "Night Changes - One Direction",
    "duration": "3:52",
    "fileUrl":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/music%2FPop%2FNight%20Changes%20English%20Full%20Mp3%20Song%20Download-BarmanMusic.Com.mp3?alt=media",
    "category": "Pop",
    "url":
        "https://firebasestorage.googleapis.com/v0/b/portfolio-my-20e16.firebasestorage.app/o/musicImages%2F1741278082996.jpg?alt=media",
  },
];
