import 'dart:developer';
import 'package:get/get.dart';
import 'package:music/controller/music_controller.dart';
import 'package:music/service/favorite_service.dart';

class FavoriteController extends GetxController {
  RxList<String> favorite = <String>[].obs;
  RxList<Map<String, dynamic>> favoriteData = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get getFavorite => favoriteData;

  void setFavorite(List<String> favoriteDataIds) {
    favorite.assignAll(favoriteDataIds);
    setFavoriteData(favoriteDataIds);
  }

  void setFavoriteData(List<String> favoriteDataIds) {
    if (!Get.isRegistered<MusicController>()) {
      log("MusicController is not registered.");
      return;
    }

    MusicController musicController = Get.find();
    List<Map<String, dynamic>> allMusic =
        musicController.getAllMusic
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    List<Map<String, dynamic>> tempFavorites =
        allMusic
            .where((music) => favoriteDataIds.contains(music["id"].toString()))
            .toList();

    favoriteData.assignAll(tempFavorites);
  }

  bool isFavorite(String id) {
    return favorite.contains(id);
  }

  void toggleFavorite(String uid, String id) {
    log("Toggling favorite for $id");
    log("Current favorite: $favorite");
    if (favorite.contains(id)) {
      favorite.removeWhere((favId) => favId == id);
      FavoriteService().removeFavorite(uid, id);
    } else {
      favorite.add(id);
      FavoriteService().addFavorite(uid, id);
    }
    setFavoriteData(favorite);
  }
}
