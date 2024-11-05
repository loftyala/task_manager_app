import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/sharedPreference/auth_controller.dart';
import 'package:task_manager_app/style/background.dart';
import '../TaskScreen/main_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      AuthController.getAccessToken();
      if (AuthController.isLoggedIn()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(),
          Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg', // Corrected path
              width: 110, // Adjust width as needed
              height: 110, // Adjust height as needed

              fit: BoxFit.cover,
            )

          ),
        ],
      ),
    );
  }
}
