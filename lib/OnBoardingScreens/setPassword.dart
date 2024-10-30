import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/style.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
                  "Set Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Minimun length of password is 8 characters with letters and numbers combination",
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
                              keyboardType: TextInputType.text,
                              decoration: inputDecoration("jsk@34#2", "Enter Password",Icon(Icons.password_outlined)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: inputDecoration("jsk@34#2", "Confirm Password",Icon(Icons.password_outlined)),
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
                                child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
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
