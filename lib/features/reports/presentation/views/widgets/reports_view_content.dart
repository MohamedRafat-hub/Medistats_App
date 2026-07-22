import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_list.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_summary_card.dart';
import 'no_reports_found.dart';

class ReportsViewContent extends StatelessWidget {
  final List<LabReportModel> reports;

  const ReportsViewContent({
    super.key,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) {
      return const NoReportsFound();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          if (reports.length > 1) ...[
            ReportsSummaryCard(
              reportsCount: reports.length,
              lastUpdated: DateFormat('dd MMMM yyyy').format(
                reports.last.uploadedAt,
              ),
            ),
            const SizedBox(height: 28),
          ],
          const Text(
            'All Reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ReportsList(reports: reports),
        ],
      ),
    );
  }
}