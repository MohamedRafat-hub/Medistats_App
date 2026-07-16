import 'package:flutter/material.dart';
import 'widgets/radiology_history_view_body.dart';

class RadiologyHistoryView extends StatelessWidget {
  const RadiologyHistoryView({super.key, required this.patientName});

  final String patientName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: RadiologyHistoryViewBody(patientName: patientName),
      ),
    );
  }
}