import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/controller/peofile_controller.dart';
import 'package:music/service/auth_service.dart';
import 'login_screen.dart'; // Import the login screen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    _nameController.dispose();
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
                            "Sign Up",
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
                          controller: _nameController,
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Name",
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
                          onTap: signUp,
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
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.inter(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.055,
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
                            Get.offAll(() => const LoginScreen());
                          },
                          child: Text(
                            "Already have an account? Login",
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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

  void signUp() async{
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
          if(await AuthService().createUserByEmailAndPass(_emailController.text, _passwordController.text,_nameController.text)){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Account created successfully",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Get.offAll(() => const LoginScreen());
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Failed to create account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please fill all the fields",
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }
}
