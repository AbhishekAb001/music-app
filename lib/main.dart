import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/view/users/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBRWA2OtE-7sO7fEhtGV_1MD1YcE3mkmu8",
      appId: "1:387554507827:android:242a3db91fc1e3274db746",
      messagingSenderId: "387554507827",
      projectId: "portfolio-my-20e16",
      storageBucket: "portfolio-my-20e16.firebasestorage.app",
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
