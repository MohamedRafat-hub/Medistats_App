import 'package:flutter/material.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'report_tile.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({super.key, required this.reports});

  final List<LabReportModel> reports;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reports.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ReportTileWidget(
          onDelete: (){},
          labReportModel: reports[index],
        );
      },
    );
  }
}
