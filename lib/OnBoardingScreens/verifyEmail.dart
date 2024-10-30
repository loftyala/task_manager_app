import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
                  "Your Email Address",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "A 6 digit verification pin will send to your email address",
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,color: Colors.white70),
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
                              decoration: inputDecoration("alalofty@gmail.com", "Enter Email",Icon(Icons.email_outlined)),
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

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,minimumSize: Size(double.infinity, 50)),
                                child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                            )
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Have  account?",style: TextStyle(color: Colors.black54),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            }, child: Text("Sign In",style: TextStyle(color: Colors.deepOrange),))
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
