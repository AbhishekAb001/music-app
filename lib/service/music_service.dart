import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class MusicService {
  Future<List<Map<String, dynamic>>> fetchAllMusics() async {
    List<Map<String, dynamic>> musics = [];
    List<String> categories = ["Sad", "Pop", "Party", "Romantic", "Marathi"];
    CollectionReference colRef = FirebaseFirestore.instance.collection("music");
    try {
      for (String category in categories) {
        DocumentSnapshot docRef = await colRef.doc(category).get();
        Map<String, dynamic> data = docRef.data() as Map<String, dynamic>;
        musics.add(data);
      }
      return musics;
    } catch (e) {
      log("Error fetching music: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchCategory() async {
    Map<String, dynamic> category = {};
    CollectionReference colRef = FirebaseFirestore.instance.collection("music");
    try {
      DocumentSnapshot docRef = await colRef.doc("category").get();
      category = docRef.data() as Map<String, dynamic>;
      return category;
    } catch (e) {
      log("Error fetching category: $e");
      return {};
    }
  }

 
}
