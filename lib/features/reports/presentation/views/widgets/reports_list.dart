import 'package:flutter/material.dart';
import 'report_tile.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ReportTile(
          icon: Icons.picture_as_pdf_outlined,
          iconColor: Color(0xFFEF4444),
          title: 'Complete Blood Count (CBC)',
          labName: 'Central Medical Lab',
          dateLabel: '10 July 2026',
          statusLabel: 'Normal',
          statusColor: Color(0xFF16A34A),
        ),
        ReportTile(
          icon: Icons.picture_as_pdf_outlined,
          iconColor: Color(0xFFEF4444),
          title: 'Liver Function Test',
          labName: 'Al Shifa Lab',
          dateLabel: '2 July 2026',
          statusLabel: 'Reviewed',
          statusColor: Color(0xFF2563EB),
        ),
        ReportTile(
          icon: Icons.image_outlined,
          iconColor: Color(0xFF2563EB),
          title: 'Thyroid Panel Scan',
          labName: 'Central Medical Lab',
          dateLabel: '19 June 2026',
          statusLabel: 'Abnormal',
          statusColor: Color(0xFFDC2626),
        ),
        ReportTile(
          icon: Icons.picture_as_pdf_outlined,
          iconColor: Color(0xFFEF4444),
          title: 'Lipid Profile',
          labName: 'Al Shifa Lab',
          dateLabel: '30 May 2026',
          statusLabel: 'Normal',
          statusColor: Color(0xFF16A34A),
        ),
      ],
    );
  }
}