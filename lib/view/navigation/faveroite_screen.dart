import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteMusicScreen extends StatefulWidget {
  const FavoriteMusicScreen({super.key});

  @override
  _FavoriteMusicScreenState createState() => _FavoriteMusicScreenState();
}

class _FavoriteMusicScreenState extends State<FavoriteMusicScreen> {
  List<Map<String, dynamic>> favoriteSongs = [
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png',
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/4/45/Divide_cover.png',
    },
    {
      'title': 'Someone Like You',
      'artist': 'Adele',
      'image': 'https://upload.wikimedia.org/wikipedia/en/a/a8/Adele_-_21.png',
    },
  ];

  void _toggleFavorite(Map<String, dynamic> song) {
    setState(() {
      if (favoriteSongs.contains(song)) {
        favoriteSongs.remove(song);
      } else {
        favoriteSongs.add(song);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF121212),
        title: Text(
          "Favorites",
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          favoriteSongs.isEmpty
              ? const Center(
                child: Text(
                  "No favorite songs yet",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: favoriteSongs.length,
                itemBuilder: (context, index) {
                  final song = favoriteSongs[index];
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
                      leading: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(song['image']),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        song['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        song['artist'],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          favoriteSongs.contains(song)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => _toggleFavorite(song),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
