import 'package:flutter/material.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Medistats',
      style: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    );
  }
}
