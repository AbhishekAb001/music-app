import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  @override
  Widget build(BuildContext context) {
    log(" data ${MediaQuery.of(context).size.width * 0.038}");
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Image.network(
                    "https://s3-alpha-sig.figma.com/img/d519/2450/a5278e328a4c0baaf9e30c8a1e782b06?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=cWerQDJl4DVeRzRREmQzL-Go9PvHboEX1Nc6DmWfm5F4LofhGsgMWUCyVxGiMVZjQyBCry07FQgoWmR6ZsdYXpm~7Vcispal~WggTyn8UxsuOnXL4ay2-Pd0aYCIKM3zs3MJX6toSDnUjx5WjKmZ0sSV2JGcLplx~lzikzY4CqJYYOsty2IYKW~Jy7YKQqDVq5Q-jQSHCaqrSZEoKXhPsmFnnC-nqku1lhwMcttPXe0MT-fbxmLtzx09hJ~V-UBxDU0PyAk~ljSVAqy3qb88VIt8cJAhlgNMITqMeaiRPxHa659XmuyjsneXPOLk2eM2iZfp-wNOZFwGNHFfrAO7MA__",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Alone in the Abyss",
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.069,
                        color: const Color.fromRGBO(230, 154, 21, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Youlakou",
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.038,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Icon(
                          Icons.ios_share_sharp,
                          color: Color.fromRGBO(230, 154, 21, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dynamic Warmup | ",
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "4 min",
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: 0.3,
                  onChanged: (value) {},
                  activeColor: const Color.fromRGBO(230, 154, 21, 1),
                  allowedInteraction: SliderInteraction.slideOnly,
                  // autofocus: false,
                  inactiveColor: const Color.fromRGBO(217, 217, 217, 0.19),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.shuffle, color: Colors.white),
                    const Icon(Icons.skip_previous, color: Colors.white),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ),
                    const Icon(Icons.skip_next, color: Colors.white),
                    const Icon(Icons.volume_up, color: Colors.white),
                    // Icon(Icons.)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
