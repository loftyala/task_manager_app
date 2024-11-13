import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/OnBoardingScreens/pinVerification.dart';
import 'package:task_manager_app/OnBoardingScreens/registration.dart';
import 'package:task_manager_app/OnBoardingScreens/setPassword.dart';
import 'package:task_manager_app/OnBoardingScreens/splash.dart';
import 'package:task_manager_app/OnBoardingScreens/verifyEmail.dart';
import 'package:task_manager_app/TaskScreen/addNewTask.dart';
import 'package:task_manager_app/TaskScreen/main_bottom_nav_bar.dart';
import 'package:task_manager_app/controllerBInder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: ControllerBinder(),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => MainBottomNavBarScreen()),
      ],
    );
  }
}
