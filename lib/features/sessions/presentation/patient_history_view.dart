import 'package:flutter/material.dart';
import 'package:medistats/core/helper_functions/show_add_session_button_sheet.dart';
import 'package:medistats/core/widgets/custom_floating_action_button.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_history_app_bar.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_session.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patients_history_view_body.dart';
import '../../../core/utils/app_theme.dart';


/// Screen showing a patient's profile summary and their session
/// history timeline. Pure UI — all data is passed in from outside.
class PatientHistoryScreen extends StatelessWidget {
  final Patient patient;
  final List<PatientSession> sessions;
  final VoidCallback? onAddSession;

  const PatientHistoryScreen({
    super.key,
    required this.patient,
    required this.sessions,
    this.onAddSession,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PatientHistoryAppBar(
        title: "${patient.firstName} ${patient.lastName}'s History",
      ),
      floatingActionButton: BottomSheetButton(
        onTap: () {
          return showAddSessionBottomSheet(context);
        },
      ),
      body: PatientsHistoryViewBody(patient: patient, sessions: sessions),
    );
  }
}

