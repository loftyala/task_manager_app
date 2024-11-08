
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/OnBoardingScreens/setPassword.dart';
import 'package:task_manager_app/style/background.dart';
import '../Data/utils.dart';
import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';

class PinVerificationPage extends StatefulWidget {
  PinVerificationPage({super.key, required this.email});
  final String email;

  @override
  State<PinVerificationPage> createState() =>
      _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
  final TextEditingController otpCtrl = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool otpInprogress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Pin Varification",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "A 6 digit varification otp has been send your email address",
                  style: textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildOTP_InputForm(),
                const SizedBox(
                  height: 30,
                ),
                buildHaveAnAccountSection()
              ],
            ),
          ),
        ),

        ],
      ),
    );
  }

  Widget buildHaveAnAccountSection() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.5),
              text: "Have an account? ",
              children: [
                TextSpan(
                  style: const TextStyle(color: Colors.black),
                  text: 'Sign In',
                  recognizer: TapGestureRecognizer()..onTap = onTapSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOTP_InputForm() {
    return Column(
      children: [
        PinCodeTextField(
          controller: otpCtrl,
          length: 6,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Future<void> onTapNextButton() async {
    otpInprogress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url:   Urls.recoverVerifyOtp(widget.email, otpCtrl.text), );

    otpInprogress = false;
    setState(() {});

    if (response.isSuccess) {

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SetPasswordScreen(
                email: widget.email,
                otp: otpCtrl.text,
              )));
    } else {
      showSnackBarMessage(context, 'Invalid code', true);
    }
  }

  void onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (_) => false);
  }
}
