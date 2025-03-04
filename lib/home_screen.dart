import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/view/navigation/music_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
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
                child: Image.network(
                  "https://s3-alpha-sig.figma.com/img/8ad7/1d81/17442aba538e3e637b9c443faaf4834c?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=jhd4w299TMhADir~Rzlv6og8XMa6wi80FQeAEhJP~ncQsF5V9PAaenfl7zNbisg5kCU4BFNmsZHJvW-UudAX0nUbKMz1uj~rJobWJNgX0CKolaQMJaZ0MIg40va4Cn5AU9BGYM1bDLyUXBgjQlxaFiTNgXdw5uFsg2uXUfacFxHCxKb03yaKr2ekAessd6q0qDeJCSqqBOztb6UxcxpUMiCYEvXRi6QMpQg7d-fE0hpIT~X~PvT8rVjoPFKs5oTwIi~BQ1i9zNXKHcniDnAjHK-ga-GWOFshcdFFx2lTAdcSuvv-pdZdBKPXwBaH0xB09HwRXhetA~5j2~~ZqVj3YA__",
                  fit: BoxFit.cover,
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
                    Text(
                      "A.L.O.N.E",
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Container(
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
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotWidth: MediaQuery.of(context).size.width * 0.025,
              dotHeight: MediaQuery.of(context).size.width * 0.025,
              dotColor: Colors.white,
              activeDotColor: const Color.fromRGBO(255, 46, 0, 1),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
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
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: const Color.fromRGBO(248, 162, 69, 1),
                      fontWeight: FontWeight.w400),
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
                return Padding(
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
                            )
                          ],
                        ),
                        child: Image.network(
                          "https://s3-alpha-sig.figma.com/img/0a67/d990/917357387a7c152b7de946bb76078e48?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=NTB-L2OYsQGh0IJRSz6r5~15ptAJ4eDdiVJuBXgT-2aJUY~JBM2bkXNbN-GH4M8TW0U-Ia1WO-~~5APkfSuPWqboAvKrUvy6fQv0OKni5PBX-qwpdujKOIwHnDiQNcKT~gILu5eMgnVniUWwjqKBL4LkOvB1fXi-yjk3sW4AotIj7UVcCz8aBpbWVY2vnBy-h2HceDjbf99VuhQfbN5yjSVRfLsELSFhATRidCcK4VGQ5XqfaGIeUQl7DkxQDIoN0qPVpZTUOZz9P4zdAP6qOSDEoXzTChQSfGQf-9HEuTOXVsyLyyI3akXuVz4iKWgiMD2oBQM1NnXzs9vT5QJ9aw__",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        "Dead Inside",
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "2020",
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
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
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: const Color.fromRGBO(248, 162, 69, 1),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MusicScreen()));
                  },
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
                            "https://s3-alpha-sig.figma.com/img/2cad/ce55/799627f3ec57b86f6f333071682f17f1?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=LAojrFVcXQRwqBVQyraqEN4kNzAk8LfVy9w~33RMdTHefd796uCpbXrroMcvSvKvYvvlpbUrGggtTTYDNw5hW1lK5t04cyLRrsaaMNgM8SkwkLnOEM2V-fovX38Nb5rDefeuuEnhbOep-FAv0ugCcbBKTH79qUuiL-Spx65~1hklMWX1QVGa6baoSHvPkOy0iU0KLqzBynai9G2Lr2ch~AD0nMqCLpssHGaJnbL8L4S39ZVa5BQ0pMcGsYLk36P80jAbG0UA874gIwS4DyYIxIc1kw7kn6BqswvfUecbaau~B2fEL5mxQS4Y7ToH0S0b-U7Bn28Uhwr0UTObfLA~pQ__",
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
                              "We Are Chaos",
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
                                    color:
                                        const Color.fromRGBO(132, 125, 125, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "\u2022 Easy Living",
                                  style: GoogleFonts.inter(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color:
                                        const Color.fromRGBO(132, 125, 125, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
