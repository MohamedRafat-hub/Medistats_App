import 'package:flutter/material.dart';

class SplashLogoIcon extends StatelessWidget {
  const SplashLogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.10),
            blurRadius: 30,
            spreadRadius: 8,
          ),
        ],
      ),
      child: const Icon(
        Icons.medical_services_rounded,
        size: 52,
        color: Colors.white,
      ),
    );
  }
}