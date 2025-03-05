import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:music/view/navigation/music_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
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
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.4,
                child: CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 2.4,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  items:
                      [
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2akOhaDxBhaaWMI9rgxFkIFFe-a7wE0DScg&s",
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2akOhaDxBhaaWMI9rgxFkIFFe-a7wE0DScg&s",
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2akOhaDxBhaaWMI9rgxFkIFFe-a7wE0DScg&s",
                      ].map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return FadeTransition(
                              opacity: _fadeAnimation,
                              child: Image.network(url, fit: BoxFit.cover),
                            );
                          },
                        );
                      }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  bottom: MediaQuery.of(context).size.width * 0.07,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        "Indian Vibes",
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 46, 0, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Subscribe",
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.049,
                            color: const Color.fromRGBO(19, 19, 19, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotWidth: MediaQuery.of(context).size.width * 0.025,
              dotHeight: MediaQuery.of(context).size.width * 0.025,
              dotColor: Colors.white,
              activeDotColor: const Color.fromRGBO(255, 46, 0, 1),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discography",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: const Color.fromRGBO(255, 46, 0, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color.fromRGBO(248, 162, 69, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.width * 0.05,
                    ),
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
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2akOhaDxBhaaWMI9rgxFkIFFe-a7wE0DScg&s",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Indian Album Title",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "2023",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Singles",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.inter(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: const Color.fromRGBO(248, 162, 69, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MusicPlayerScreen(
                              initialIndex: 0,
                              playlist: [
                                {
                                  "title": "Blinding Lights",
                                  "artist": "The Weeknd",
                                  "imageUrl":
                                      "https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png",
                                  "audioUrl":
                                      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                                },
                                {
                                  "title": "Shape of You",
                                  "artist": "Ed Sheeran",
                                  "imageUrl":
                                      "https://upload.wikimedia.org/wikipedia/en/4/45/Divide_cover.png",
                                  "audioUrl":
                                      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
                                },
                                {
                                  "title": "Memories",
                                  "artist": "Maroon 5",
                                  "imageUrl":
                                      "https://upload.wikimedia.org/wikipedia/en/4/49/Maroon_5_-_Memories.png",
                                  "audioUrl":
                                      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
                                },
                              ],
                            ),
                      ),
                    );
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.02,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.width * 0.23,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2akOhaDxBhaaWMI9rgxFkIFFe-a7wE0DScg&s",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Indian Single Title",
                                style: GoogleFonts.inter(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(203, 200, 200, 1),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "2023",
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.03,
                                      color: const Color.fromRGBO(
                                        132,
                                        125,
                                        125,
                                        1,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "\u2022 Indian Artist",
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.03,
                                      color: const Color.fromRGBO(
                                        132,
                                        125,
                                        125,
                                        1,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.more_vert, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _currentPage = 0;
}
