import 'package:flutter/material.dart';

class CenterCircularProgress extends StatelessWidget {
  const CenterCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
