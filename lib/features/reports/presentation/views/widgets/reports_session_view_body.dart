import 'package:flutter/material.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_list.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_summary_card.dart';

import 'latest_report_card.dart';


class ReportsSessionViewBody extends StatelessWidget {
  const ReportsSessionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReportsSummaryCard(reportsCount: 4, lastUpdated: '10 Jul'),
          const SizedBox(height: 20),
          LatestReportCard(
            icon: Icons.picture_as_pdf_outlined,
            title: 'Complete Blood Count (CBC)',
            labName: 'Central Medical Lab',
            dateLabel: '10 July 2026',
            statusLabel: 'Normal',
            statusColor: const Color(0xFF16A34A),
            onView: () {},
          ),
          const SizedBox(height: 28),
          const Text(
            'All Reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          const ReportsList(),
        ],
      ),
    );
  }
}