import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/style/background.dart';

class PinVerificationPage extends StatefulWidget {
  @override
  _PinVerificationPageState createState() => _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
  String pinCode = "";

  void _submitPin() {
    if (pinCode.length == 6) {
      // Process the PIN code
      print('PIN Entered: $pinCode');
      // Add your verification logic here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid 6-digit PIN.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PIN Verification')),
      body: Stack(
        children: [
          ScreenBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.scale,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              inactiveColor: Colors.grey,
              activeColor: Colors.blue,
              selectedColor: Colors.green,
            ),
            cursorColor: Colors.black,
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
            onChanged: (value) {
              setState(() {
                pinCode = value;
              });
            },
            onCompleted: (value) {
              print("Completed: $value");
            },
          ),

        SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPin,
                child: Text('Verify PIN'),
              ),
            ],
          ),
        ]


      ),
    );
  }
}
