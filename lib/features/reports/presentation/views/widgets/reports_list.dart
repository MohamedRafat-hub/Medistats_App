import 'package:flutter/material.dart';
import 'report_tile.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ReportTileWidget(
          fileUrl:
              'https://xulmhyugedrlssasyagy.supabase.co/storage/v1/object/public/lab_reports/patients/TgUcEGWAVo6oy6fXNgyN/report_1784560038737.pdf',
          fileName: 'Assembly',
        ),
      ],
    );
  }
}
