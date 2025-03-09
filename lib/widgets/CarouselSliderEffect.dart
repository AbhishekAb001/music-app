import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:music/view/navigation/music_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderEffect extends StatefulWidget {
  final List<Map<dynamic, dynamic>> carouselSongs;

  const CarouselSliderEffect({Key? key, required this.carouselSongs})
    : super(key: key);

  @override
  State<CarouselSliderEffect> createState() => _CarouselSliderEffectState();
}

class _CarouselSliderEffectState extends State<CarouselSliderEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.carouselSongs.length,
          carouselController: _carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 2.4,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // Background Image with Fade Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.network(
                    widget.carouselSongs[index]["url"]!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),

                // Positioned Name & Subscribe Button (Bottom Left)
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.04,
                  bottom: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            widget.carouselSongs[index]["songName"]!,
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        widget.carouselSongs[index]["artist"]!,
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              MusicPlayerScreen(
                                initialIndex: index,
                                playlist: widget.carouselSongs,
                              ),
                              transition: Transition.downToUp,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 46, 0, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        // SmoothPageIndicator (Bottom Center)
        SizedBox(height: MediaQuery.of(context).size.width * 0.04),
        AnimatedSmoothIndicator(
          activeIndex: _currentPage,
          count: widget.carouselSongs.length,
          effect: ExpandingDotsEffect(
            dotWidth: MediaQuery.of(context).size.width * 0.025,
            dotHeight: MediaQuery.of(context).size.width * 0.025,
            dotColor: Colors.white,
            activeDotColor: const Color.fromRGBO(255, 46, 0, 1),
          ),
          onDotClicked: (index) {
            _carouselController.animateToPage(index);
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ],
    );
  }
}
