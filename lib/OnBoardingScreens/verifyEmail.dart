import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/OnBoardingScreens/pinVerification.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';

import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
 // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _inProgress = false;



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
                  "Your Email Address",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "A 6-digit verification pin will be sent to your email address",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: boxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: buildAllTextFormField(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form buildAllTextFormField(BuildContext context) {
    return Form(
     // key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
                decoration: inputDecoration("alalofty@gmail.com", "Enter Email", Icon(Icons.email_outlined)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            shadowColor: Colors.deepOrange,
            elevation: 10,
            color: Colors.deepOrange,
            child: Visibility(
              visible: !_inProgress,
              replacement: Center(child: CircularProgressIndicator()),
              child: ElevatedButton(
                onPressed: _onTapLoginButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have an account?", style: TextStyle(color: Colors.black54)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Sign In", style: TextStyle(color: Colors.deepOrange)),
              )
            ],
          ),
        ],
      ),
    );
  }
  void _onTapLoginButton() {

      _signIn(); // Call signIn() only if the form is valid
    }


  Future<void> _signIn() async {
    setState(() {
      _inProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.postRequest(
      url:  Urls.recoverVerifyEmail,
      body: {
        'email': _emailController.text,
      },
    );

    setState(() {
      _inProgress = false;
    });

    if (response.isSuccess) {
      _showSnackBar('A 6-digit verification pin has been sent to your email address');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>PinVerificationPage(email: _emailController.text) ),
            (Route<dynamic> route) => false,
      );
    } else {
      _showSnackBar(response.errorMessage);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

}

