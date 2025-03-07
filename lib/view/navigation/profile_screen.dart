import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/shered_prefrence_service.dart';
import 'package:music/view/users/login_screen.dart';

class MusicProfileScreen extends StatelessWidget {
  MusicProfileScreen({super.key});

  ProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                SharedPreferenceService.setLoginPref("", false);
                Get.offAll(LoginScreen());
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.18,
                backgroundImage: Image.asset("assets/avatar.jpg").image,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            Text(
              controller.profile['name'] ?? "Artist Name",
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
            Text(
              "Music Genre | 5M Monthly Listeners",
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileStat(title: "Listeners", value: "5M"),
                ProfileStat(title: "Albums", value: "12"),
                ProfileStat(title: "Songs", value: "45"),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.width * 0.05),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "About",
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    "A passionate music artist bringing soulful melodies and energetic beats to fans worldwide.",
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.width * 0.05),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Top Songs",
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.03),

            Expanded(
              child: ListView(
                children: const [
                  SongTile(songName: "Song 1", duration: "3:45"),
                  SongTile(songName: "Song 2", duration: "4:10"),
                  SongTile(songName: "Song 3", duration: "2:58"),
                  SongTile(songName: "Song 4", duration: "3:30"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const ProfileStat({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class SongTile extends StatelessWidget {
  final String songName;
  final String duration;

  const SongTile({super.key, required this.songName, required this.duration});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.music_note, color: Colors.white),
      title: Text(
        songName,
        style: GoogleFonts.inter(
          fontSize: MediaQuery.of(context).size.width * 0.045,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        duration,
        style: GoogleFonts.inter(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(Icons.play_arrow, color: Colors.white),
    );
  }
}
