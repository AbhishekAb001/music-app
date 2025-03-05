import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music/service/profile_cloud_service.dart';

class AuthService {
  Future<bool> createUserByEmailAndPass(
    String email,
    String password,
    String name,
  ) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          try {
            ProfileCloudService().addUserDetails({
              "uid": value.user!.uid,
              "email": email,
              "name": name,
              "password": hashPassword(password),
            });
            return true;
          } catch (error) {
            log("Error during user creation: $error");
            return false;
          }
        })
        .catchError((error) {
          return false;
        });

    return true;
  }

  Future<UserCredential?> signInByEmailAndPass(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (error) {
      log("Error during sign-in: $error");
      return null;
    }
  }

  Future<UserCredential?> createUserByGoogle() async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithProvider(
        GoogleAuthProvider(),
      );

      ProfileCloudService().addUserDetails({
        "uid": user.user!.uid,
        "email": user.user!.email,
        "name": user.user!.displayName,
        "password": "",
      });
      return user;
    } catch (error) {
      log("Error during Google sign-in: $error");
      return null;
    }
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var hased = sha256.convert(bytes);
    return hased.toString();
  }
}
