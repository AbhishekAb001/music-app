import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicCategoryScreen extends StatelessWidget {
  const MusicCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark theme
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF121212),
        title: Text(
          "Categories",
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
            mainAxisSpacing: MediaQuery.of(context).size.width * 0.04,
            childAspectRatio: 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return MusicCategoryCard(
              title: categories[index]['title'],
              imageUrl: categories[index]['image'],
              icon: categories[index]['icon'],
            );
          },
        ),
      ),
    );
  }
}

class MusicCategoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final IconData icon;

  const MusicCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.icon,
  });

  @override
  _MusicCategoryCardState createState() => _MusicCategoryCardState();
}

class _MusicCategoryCardState extends State<MusicCategoryCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            isTapped
                ? Matrix4.identity().scaled(0.97) // Slight shrink on tap
                : Matrix4.identity().scaled(1.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7), // Stronger shadow for depth
              blurRadius: 12,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg', // Local placeholder
                image: widget.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      'assets/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(
                      0.3,
                    ), // Reduced opacity for clarity
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Icon(widget.icon, color: Colors.white70, size: 30),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      color: Colors.black87,
                      blurRadius: 4,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Music Categories Data
List<Map<String, dynamic>> categories = [
  {
    "title": "Genres",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.music_note,
  },
  {
    "title": "Instruments",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.piano,
  },
  {
    "title": "Artists",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.mic,
  },
  {
    "title": "Albums",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.album,
  },
  {
    "title": "Playlists",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.queue_music,
  },
  {
    "title": "Live Shows",
    "image":
        "https://wallpapers.com/images/featured/romance-pictures-9nus2ne9xefezvcs.jpg",
    "icon": Icons.theater_comedy,
  },
];
