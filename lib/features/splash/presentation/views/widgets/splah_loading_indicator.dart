import 'package:flutter/material.dart';

/// Minimal circular progress indicator shown at the bottom of the splash.
/// Pure UI — the navigation logic lives in the Cubit / router layer.
class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }
}