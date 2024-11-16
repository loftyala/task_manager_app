import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/singIn_controller.dart';
import '../style/background.dart';
import '../style/style.dart';
import 'registration.dart';
import 'verifyEmail.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Get Started \n With Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: boxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _buildForm(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: inputDecoration(
                    "alalofty@gmail.com",
                    "Enter Email",
                    Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: inputDecoration(
                    "jsk@34#2",
                    "Enter Password",
                    Icon(Icons.password_outlined),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Login", style: TextStyle(color: Colors.white)),
              );
            }),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(() => VerifyEmailScreen());
              },
              child: Text("Forgot Password?", style: TextStyle(color: Colors.black54)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: TextStyle(color: Colors.black54)),
                TextButton(
                  onPressed: () {
                    Get.to(() => RegistrationScreen());
                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.deepOrange)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
