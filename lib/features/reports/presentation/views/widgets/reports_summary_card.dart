import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class ReportsSummaryCard extends StatelessWidget {
  const ReportsSummaryCard({
    super.key,
    required this.reportsCount,
    required this.lastUpdated,
  });

  final int reportsCount;
  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              icon: Icons.folder_copy_outlined,
              value: '$reportsCount',
              label: reportsCount == 1 ? 'Report' : 'Reports',
              iconColor: AppColors.primaryColor,
            ),
          ),
          Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
          Expanded(
            child: _SummaryItem(
              icon: Icons.calendar_today_outlined,
              value: lastUpdated,
              label: 'Last Updated',
              iconColor: const Color(0xFF0EA5A5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 17, color: iconColor),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}