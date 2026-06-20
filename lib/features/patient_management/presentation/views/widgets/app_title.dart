
import 'package:flutter/material.dart';
class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Medistats',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C5F6F),
      ),
    );
  }
}
