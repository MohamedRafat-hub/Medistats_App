import 'package:flutter/material.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_session_view_body.dart';
import 'package:medistats/features/reports/presentation/views/widgets/upload_reports_button_consumer.dart';
import 'widgets/reports_session_app_bar.dart';

class ReportsSessionView extends StatelessWidget {
  const ReportsSessionView({
    super.key,
    required this.patientName,
    required this.patientId, required this.sessionId,
  });

  final String patientName;
  final String patientId;
  final String sessionId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: ReportsSessionAppBar(patientName: patientName),
      body: ReportsSessionViewBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: UploadReportButtonBlocConsumer(
        patientId: patientId,
        sessionId: sessionId,
      ),
    );
  }
}


