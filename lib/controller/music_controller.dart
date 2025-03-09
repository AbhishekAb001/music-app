import 'dart:math';

import 'package:get/get.dart';

class MusicController extends GetxController {
  RxList<Map<String, dynamic>> musics = <Map<String, dynamic>>[].obs;

  void setMusics(List<Map<String, dynamic>> musicData) {
    musics.value = musicData;
  }

  List<Map<String, dynamic>> get getMusics => musics;

  // Pop music data for sliding effect of the home screen
  List<Map<dynamic, dynamic>> get getPopMusics {
    List<Map<dynamic, dynamic>> randomMusic = [];
    Map<String, dynamic> music = musics[1];
    for (int i = 1; i <= 4; i++) {
      randomMusic.add(music[i.toString()]);
    }
    return randomMusic;
  }

  //List of all music data
  List<Map<dynamic, dynamic>> get getAllMusic {
    List<Map<dynamic, dynamic>> allMusic = [];
    for (int i = 0; i < musics.length; i++) {
      Map<String, dynamic> music = musics[i];
      for (int j = 1; j <= 4; j++) {
        allMusic.add(music[j.toString()]);
      }
    }
    return allMusic;
  }

  int getRandomIndexExcluding(int exclude, int length) {
    int randomIndex;
    do {
      randomIndex = Random().nextInt(length);
    } while (randomIndex == exclude);
    return randomIndex;
  }

  // Random music data
  List<Map<dynamic, dynamic>> get getRandomMusics {
    List<Map<dynamic, dynamic>> randomMusics = [];

    int randomIndex = getRandomIndexExcluding(1, musics.length);
    Map<String, dynamic> music = musics[randomIndex];

    for (int j = 1; j <= 4; j++) {
      randomMusics.add(music[j.toString()]);
    }

    return randomMusics;
  }

  List<Map<dynamic, dynamic>> getMusicByCategory(String category) {
    List<Map<dynamic, dynamic>> musicByCategory = [];
    final musics = getAllMusic;
    for (int i = 0; i < musics.length; i++) {
      if (musics[i]['category'] == category) {
        musicByCategory.add(musics[i]);
      }
    }
    return musicByCategory;
  }
}
