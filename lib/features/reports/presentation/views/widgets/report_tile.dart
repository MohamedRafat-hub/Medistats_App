import 'package:flutter/material.dart';
import 'package:medistats/features/reports/presentation/views/widgets/report_status_bage.dart';

import 'report_type_icon.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.labName,
    required this.dateLabel,
    required this.statusLabel,
    required this.statusColor,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String labName;
  final String dateLabel;
  final String statusLabel;
  final Color statusColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReportTypeIcon(
                  icon: icon,
                  color: iconColor,
                  size: 24,
                  padding: 12,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.science_outlined,
                            size: 13,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              labName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('•', style: TextStyle(color: Colors.grey.shade400)),
                          const SizedBox(width: 6),
                          Text(
                            dateLabel,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ReportStatusBadge(label: statusLabel, color: statusColor),
                    const SizedBox(height: 10),
                    Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}