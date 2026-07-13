import 'package:flutter/material.dart';

class XraySummaryCard extends StatelessWidget {
  const XraySummaryCard({
    super.key,
    required this.imagesCount,
    required this.lastUpdated,
  });

  final int imagesCount;
  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SummaryItem(
            icon: Icons.badge_outlined,
            label: '$imagesCount Images',
            iconColor: const Color(0xFF4361EE),
          ),
          _SummaryItem(
            icon: Icons.calendar_today_outlined,
            label: 'Last Updated: $lastUpdated',
            iconColor: Colors.black54,
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
