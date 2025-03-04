import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicSearchScreen extends StatefulWidget {
  const MusicSearchScreen({super.key});

  @override
  _MusicSearchScreenState createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredCategories = musicCategories;

  void _filterCategories(String query) {
    setState(() {
      filteredCategories =
          musicCategories
              .where(
                (category) =>
                    category.toLowerCase().contains(query.toLowerCase()),
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
              onChanged: _filterCategories,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search music categories...",
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
                filteredCategories.isEmpty
                    ? const Center(
                      child: Text(
                        "No categories found",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
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
                            leading: const Icon(
                              Icons.music_note,
                              color: Colors.white70,
                            ),
                            title: Text(
                              filteredCategories[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              // Handle category selection
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

// Sample Music Categories
List<String> musicCategories = [
  // "Pop",
  // "Rock",
  // "Hip-Hop",
  // "Jazz",
  // "Classical",
  // "Electronic",
  // "Reggae",
  // "Country",
  // "Blues",
  // "Folk",
  // "Latin",
  // "Metal",
];
