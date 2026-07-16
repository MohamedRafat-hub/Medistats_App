import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class AddXrayButton extends StatelessWidget {
  const AddXrayButton({super.key, this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(18),
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}