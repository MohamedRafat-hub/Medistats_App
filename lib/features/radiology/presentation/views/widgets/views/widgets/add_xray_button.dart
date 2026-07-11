import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class AddXrayButton extends StatelessWidget {
  const AddXrayButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

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
      child: const Icon(Icons.camera_alt_outlined, size: 24),
    );
  }
}