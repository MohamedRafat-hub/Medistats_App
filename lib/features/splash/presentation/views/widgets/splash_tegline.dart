import 'package:flutter/material.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Internal Medicine Clinic',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(0.75),
        letterSpacing: 2.0,
      ),
    );
  }
}