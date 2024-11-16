import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';

import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, this.otp});
  final String email;
  final otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final RxBool recoveryPassInProgress = false.obs; // Use RxBool for reactive state

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
                  "Set Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Minimum length of password is 8 characters with letters and numbers combination",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: boxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: buildTextField(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form buildTextField(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordCtrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid password";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: inputDecoration("jsk@34#2", "Enter Password", Icon(Icons.password_outlined)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: confirmPasswordCtrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Confirm your password";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: inputDecoration("jsk@34#2", "Confirm Password", Icon(Icons.password_outlined)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => Card(
            shadowColor: Colors.deepOrange,
            elevation: 10,
            color: Colors.deepOrange,
            child: ElevatedButton(
              onPressed: recoveryPassInProgress.value ? null : () => OntapConfirmButton(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange, minimumSize: Size(double.infinity, 50)),
              child: recoveryPassInProgress.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                "Confirm",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" Have an account?", style: TextStyle(color: Colors.black54)),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Sign In", style: TextStyle(color: Colors.deepOrange)))
            ],
          ),
        ],
      ),
    );
  }

  void OntapConfirmButton() {
    if (_globalKey.currentState!.validate()) {
      changePassword();
    } else {
      print('Validation failed');
    }
  }

  Future<void> changePassword() async {
    recoveryPassInProgress.value = true;

    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": passwordCtrl.text
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.recoverResetPassword,
      body: requestBody,
    );

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Password changed successfully', true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
            (_) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    recoveryPassInProgress.value = false;
  }
}
