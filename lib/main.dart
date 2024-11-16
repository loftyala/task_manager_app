import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/Controller/singIn_controller.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/OnBoardingScreens/splash.dart';
import 'package:task_manager_app/TaskScreen/main_bottom_nav_bar.dart';

void main() {
  // Initialize necessary dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Register controllers here
    Get.lazyPut(() => LoginController());

    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => MainBottomNavBarScreen()),
      ],
    );
  }
}
