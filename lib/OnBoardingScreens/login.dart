import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';
import 'package:task_manager_app/Data/Service/networkCaller.dart';
import 'package:task_manager_app/Data/utils.dart';
import 'package:task_manager_app/OnBoardingScreens/registration.dart';
import 'package:task_manager_app/TaskScreen/main_bottom_nav_bar.dart';
import 'package:task_manager_app/sharedPreference/auth_controller.dart';
import 'package:task_manager_app/style/style.dart';
import '../style/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration("alalofty@gmail.com", "Enter Email",
                      Icon(Icons.email_outlined)),
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: true, // Make password field obscure
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be more than 6 characters";
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
                shadowColor: Colors.deepOrange,
                elevation: 10,
                color: Colors.deepOrange,
                child: Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: _onTapLoginButton,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange, minimumSize: Size(double.infinity, 50)),
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                )),
            SizedBox(height: 20),
            Text("Forgot Password?", style: TextStyle(color: Colors.black54)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: TextStyle(color: Colors.black54)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                    },
                    child: Text("Sign Up", style: TextStyle(color: Colors.deepOrange))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    if (_formKey.currentState!.validate()) {
      _signIn(); // Call signIn() only if the form is valid
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _inProgress = true;
    });

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.login,
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    setState(() {
      _inProgress = false;
    });

    if (response.isSuccess) {
      await AuthController.saveAccessToken(response.responseData["token"]);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainBottomNavBarScreen()),
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
