import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class AddXrayButton extends StatelessWidget {
  const AddXrayButton({super.key, this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        elevation: 4,
      ),
      child: child,
    );
  }
}