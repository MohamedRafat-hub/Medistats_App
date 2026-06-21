import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';


/// A small rounded pill showing a patient condition or note,
/// with an icon and label.
class ConditionBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;

  const ConditionBadge({
    super.key,
    required this.label,
    required this.icon,
    this.iconColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.badgeBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.badgeText),
        ],
      ),
    );
  }
}
