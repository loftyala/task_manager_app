import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/Data/Model/loginModel.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';
import 'package:task_manager_app/Data/Service/networkCaller.dart';
import 'package:task_manager_app/Data/utils.dart';
import 'package:task_manager_app/TaskScreen/main_bottom_nav_bar.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty.");
      return;
    }

    isLoading(true);

    final response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    isLoading(false);

    if (response.isSuccess) {
      final loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      Get.offAll(() => MainBottomNavBarScreen());
    } else {
      Get.snackbar("Login Failed", response.errorMessage);
    }
  }
}
