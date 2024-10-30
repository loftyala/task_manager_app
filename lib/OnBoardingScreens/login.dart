import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/registration.dart';
import 'package:task_manager_app/TaskScreen/main_bottom_nav_bar.dart';
import 'package:task_manager_app/style/style.dart';
import '../style/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Correctly instantiate Stack as a child of Scaffold
        children: [
          ScreenBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(height: 40), // Correctly wrap SizedBox
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Get Started \n With Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
             Expanded(
               child: Container(
                 decoration: boxDecoration(),
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: [
                       SizedBox(height: 20),
                       Card(
                         elevation: 10,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextField(
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
                           child: TextField(
                             keyboardType: TextInputType.text,
                             decoration: inputDecoration("jsk@34#2", "Enter Password",Icon(Icons.password_outlined)),
                           ),
                         ),
                       ),
                       SizedBox(height: 20),
                       Card(

                           shadowColor: Colors.deepOrange,
                           elevation: 10,
                           color: Colors.deepOrange,
                           child: ElevatedButton(
                               onPressed: (){
                                 Navigator.of(context).pushAndRemoveUntil(
                                   MaterialPageRoute(builder: (context) => MainBottomNavBarScreen()),
                                       (Route<dynamic> route) => false,
                                 );



                               },
                               style: ElevatedButton.styleFrom(
                                   backgroundColor: Colors.deepOrange,minimumSize: Size(double.infinity, 50)),
                               child: Text("Login",style: TextStyle(color: Colors.white),))),
                       SizedBox(height: 20),
                       Text("Forgot Password?",style: TextStyle(color: Colors.black54),),
                        SizedBox(height: 20),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Don't have an account?",style: TextStyle(color: Colors.black54),),
                           TextButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                           }, child: Text("Sign Up",style: TextStyle(color: Colors.deepOrange),))
                         ],
                       ),


                     ],
                   ),
                 ),


               ),
             ),
            ],
          ),
        ],
      ),
    );
  }
}
