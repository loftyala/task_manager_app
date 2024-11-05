import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';
import 'package:task_manager_app/Data/Service/networkCaller.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:http/http.dart' as http;
import '../Data/utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _inProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Join With Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              Container(
                decoration: boxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buildAllTextField(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAllTextField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration("alalofty@gmail.com", "Enter Email", Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                decoration: inputDecoration("Enter your First name", "Enter First Name", Icon(Icons.person_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _lastNameController,
                keyboardType: TextInputType.text,
                decoration: inputDecoration("Enter your Last name", "Enter Last Name", Icon(Icons.person_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration("Enter your Mobile Number", "Enter Mobile Number", Icon(Icons.phone_android_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                keyboardType: TextInputType.text,
                decoration: inputDecoration("jsk@34#2", "Enter Password", Icon(Icons.password_outlined)),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            shadowColor: Colors.deepOrange,
            elevation: 10,
            color: Colors.deepOrange,
            child: Visibility(
              visible: _inProgress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ElevatedButton(
                onPressed: _onTapRegisterButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Register", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have account?", style: TextStyle(color: Colors.black54)),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Sign In", style: TextStyle(color: Colors.deepOrange)),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onTapRegisterButton() {
    if (_formKey.currentState!.validate()) {
      _registration();
    }
  }

  Future<void> _registration() async {
    setState(() {
      _inProgress = true;
    });

    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registration,
      body: {
        'email': _emailController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
      },
    );

    if (!mounted) return; // Check if the widget is still in the tree

    setState(() {
      _inProgress = false;
    });

    if (response.isSuccess) {
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration successful")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration failed: ${response.errorMessage}")));
    }
  }

  void _clearTextFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _emailController.clear();
  }

}


