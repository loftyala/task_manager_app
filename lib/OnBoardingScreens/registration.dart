import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _FirstNameController = TextEditingController();
  final TextEditingController _LastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _FirstNameController.dispose();
    _LastNameController.dispose();
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
                controller: _FirstNameController,
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
                controller: _LastNameController,
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
            child: ElevatedButton(
              onPressed: OntapRegisterButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Register", style: TextStyle(color: Colors.white)),
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

  void OntapRegisterButton() {
    if (_formKey.currentState!.validate()) {
      // Proceed with registration logic
      return;

    }
  }

}
