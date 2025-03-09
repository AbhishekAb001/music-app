import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/categories_controller.dart';
import 'package:music/view/navigation/selected_category.dart';

class MusicCategoryScreen extends StatefulWidget {
  const MusicCategoryScreen({super.key});

  @override
  _MusicCategoryScreenState createState() => _MusicCategoryScreenState();
}

class _MusicCategoryScreenState extends State<MusicCategoryScreen> {
  final CategoriesController categoriesController = Get.put(
    CategoriesController(),
  );
  List<Map<dynamic, dynamic>> categories = [];

  final List<IconData> icons = [
    Icons.music_note,
    Icons.party_mode,
    Icons.library_music,
    Icons.favorite,
    Icons.sentiment_dissatisfied,
  ];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    final fetchedCategories = categoriesController.fetchCategories();
    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF121212),
        title: Text(
          "Categories",
          style: GoogleFonts.inter(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body:
          categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: width * 0.04,
                    mainAxisSpacing: width * 0.04,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Map<dynamic, dynamic> category = categories[index];
                    return MusicCategoryCard(
                      title: category['name'] ?? "Unknown",
                      imageUrl: category['url'] ?? "Unknown",
                      icon: icons[index % icons.length],
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
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTapDown: (_) => setState(() => isTapped = true),
      onTapUp: (_) => setState(() => isTapped = false),
      onTapCancel: () => setState(() => isTapped = false),
      onTap: () {
        Get.to(
          () => SelectedCategory(category: widget.title, url: widget.imageUrl),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            isTapped
                ? Matrix4.identity().scaled(0.97)
                : Matrix4.identity().scaled(1.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: width * 0.03,
              offset: Offset(width * 0.01, width * 0.02),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.04),
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/placeholder.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.04),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: width * 0.03,
              child: Icon(
                widget.icon,
                color: Colors.redAccent,
                size: width * 0.08,
              ),
            ),
            Positioned(
              bottom: width * 0.1,
              left: width * 0.03,
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: width * 0.045,
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
