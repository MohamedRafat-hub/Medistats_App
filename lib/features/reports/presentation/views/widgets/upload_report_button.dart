import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class UploadReportButton extends StatelessWidget {
  const UploadReportButton({super.key, this.onPressed, this.widget});

  final VoidCallback? onPressed;
  final Widget? widget;
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
        child: widget,
      ),
    );
  }
}