import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  Future<bool> addFavorite(String uid, String musicId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({
          "favorite": FieldValue.arrayUnion([musicId]),
        })
        .then((value) {
          return true;
        })
        .catchError((error) {
          return false;
        });
    return true;
  }

  Future<bool> removeFavorite(String uid, String musicId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({
          "favorite": FieldValue.arrayRemove([musicId]),
        })
        .then((value) {
          return true;
        })
        .catchError((error) {
          return false;
        });
    return true;
  }

  Future<List<String>> getFavorite(String uid) async {
    if (uid.isEmpty) {
      log("UID is empty");
      return [];
    }
    List<String> favorite = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
          favorite = List<String>.from(value.data()!["favorite"]);
        })
        .catchError((error) {
          favorite = [];
        });
    return favorite;
  }
}
