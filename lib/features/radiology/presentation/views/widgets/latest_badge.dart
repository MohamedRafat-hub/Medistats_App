import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class LatestBadge extends StatelessWidget {
  const LatestBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 15, color: Colors.white),
          SizedBox(width: 6),
          Text(
            'LATEST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}