import 'package:flutter/material.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_session_view_body.dart';
import 'widgets/reports_session_app_bar.dart';
import 'widgets/upload_report_button.dart';

class ReportsSessionView extends StatelessWidget {
  const ReportsSessionView({
    super.key,
    this.patientName = 'Patient Name',
  });

  final String patientName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: ReportsSessionAppBar(patientName: patientName),
      body: const ReportsSessionViewBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: UploadReportButton(
        onPressed: () {
          // TODO: wire this to your upload logic (Cubit + file picker),
          // the same way UploadXrayBlocListener wraps AddXrayButton
          // in the radiology feature.
        },
      ),
    );
  }
}



