import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/OnBoardingScreens/pinVerification.dart';
import 'package:task_manager_app/OnBoardingScreens/registration.dart';
import 'package:task_manager_app/OnBoardingScreens/setPassword.dart';
import 'package:task_manager_app/OnBoardingScreens/splash.dart';
import 'package:task_manager_app/OnBoardingScreens/verifyEmail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home://PinVerificationPage()
      //SetPasswordScreen()
      //VerifyEmailScreen()
      //RegistrationScreen()
      LoginScreen()
      //SplashScreen(),

    );
  }
}
