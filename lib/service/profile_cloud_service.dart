import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCloudService {

  Future<bool> addUserDetails(Map<String, dynamic> userDetails) async {
    FirebaseFirestore.instance.collection("users").doc(userDetails["uid"]).set(userDetails).then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
    return true;
  }

  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    Map<String, dynamic>? userDetails;
    await FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      userDetails = value.data();
    }).catchError((error) {
      userDetails = null;
    });
    return userDetails;
  }
}