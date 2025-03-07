import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/auth_service.dart';
import 'package:music/service/music_service.dart';
import 'package:music/service/profile_cloud_service.dart';
import 'package:music/service/shered_prefrence_service.dart';
import 'package:music/view/navigation/navigation_screen.dart';
import 'package:music/view/users/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ProfileController controller = Get.find();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bgc.png", fit: BoxFit.cover),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.5),
                    Column(
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Text(
                            "Login",
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                        ),
                        TextField(
                          controller: _emailController,
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        TextField(
                          controller: _passwordController,
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.06,
                        ),
                        GestureDetector(
                          onTap: login,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.04,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.25,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(255, 46, 0, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child:
                                (isLoading)
                                    ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: const Color.fromARGB(
                                        255,
                                        171,
                                        58,
                                        58,
                                      ),
                                      size:
                                          MediaQuery.of(context).size.width *
                                          0.1,
                                    )
                                    : Text(
                                      "Login",
                                      style: GoogleFonts.inter(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.055,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignupScreen());
                          },
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.08,
                        ),
                        Text(
                          "------ Or login with ------",
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: const Color.fromARGB(188, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        GestureDetector(
                          onTap: signupWithGoogle,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromRGBO(255, 46, 0, 1),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.g_mobiledata,
                              color: const Color.fromRGBO(255, 46, 0, 1),
                              size: MediaQuery.of(context).size.width * 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signupWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    UserCredential? user = await AuthService().createUserByGoogle();
    if (user != null) {
      ProfileCloudService().getUserDetails(user.user!.uid).then((value) {
        controller.setProfile(value!);
      });
      SharedPreferenceService.setLoginPref(user.user!.uid, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 77, 86, 79),
          content: Text(
            "Signed up successfully",
            style: GoogleFonts.inter(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      _fetchMusics();
      setState(() {
        isLoading = false;
      });
      Get.offAll(NavigationScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromRGBO(255, 46, 0, 1),
          content: Text(
            "An error occurred while signing up",
            style: GoogleFonts.inter(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void login() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      UserCredential? user = await AuthService().signInByEmailAndPass(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Map<String, dynamic>? userInfo = await ProfileCloudService()
            .getUserDetails(user.user!.uid);
        SharedPreferenceService.setLoginPref(user.user!.uid, true);
        controller.setProfile(userInfo!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Login successful",
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
        _fetchMusics();
        setState(() {
          isLoading = false;
        });
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(() => NavigationScreen());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Invalid email or password",
              style: GoogleFonts.inter(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please fill in all fields",
            style: GoogleFonts.inter(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  void _fetchMusics() async {
    try {
      Box box = await Hive.openBox("musics");
      var musics = await MusicService().fetchAllMusics();
      await box.put("musics", musics);
    } catch (e) {
      log("Error fetching musics: $e");
    }
  }
}
