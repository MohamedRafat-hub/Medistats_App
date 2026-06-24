import 'package:flutter/material.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_info_card.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_session.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/session_timeline_tile.dart';

class PatientsHistoryViewBody extends StatelessWidget {
  const PatientsHistoryViewBody({
    super.key,
    required this.patient,
    required this.sessions,
  });

  final PatientModel patient;
  final List<PatientSession> sessions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          PatientInfoCard(patient: patient),
          const SizedBox(height: 24),
          for (var i = 0; i < sessions.length; i++)
            SessionTimelineTile(
              session: sessions[i],
              isLast: i == sessions.length - 1,
            ),
        ],
      ),
    );
  }
}
