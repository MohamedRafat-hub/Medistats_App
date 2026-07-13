import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/sessions/presentation/managers/get_patient_sessions_cubit/get_patient_sessions_cubit.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_info_card.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/session_timeline_tile.dart';

class PatientsHistoryViewBody extends StatefulWidget {
  const PatientsHistoryViewBody({super.key, required this.patient});

  final PatientModel patient;

  @override
  State<PatientsHistoryViewBody> createState() => _PatientsHistoryViewBodyState();
}

class _PatientsHistoryViewBodyState extends State<PatientsHistoryViewBody> {
  @override
  void dispose() {
    debugPrint("PatientHistoryView Dispose");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("PatientHistoryView Build");
    return SafeArea(
      child: BlocBuilder<GetPatientSessionsCubit, GetPatientSessionsState>(
        builder: (context, state) {
          log(state.toString());
          if (state is GetPatientSessionsLoading) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetPatientSessionsFailure) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                children: [
                  PatientInfoCard(patient: widget.patient),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetPatientSessionsSuccess) {
            final sessions = state.sessions;

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              physics: const BouncingScrollPhysics(),
              children: [
                // PatientInfoCard(patient: widget.patient),
                const SizedBox(height: 24),

                if (sessions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Center(
                      child: Text(
                        'There are no recorded sessions for this patient yet.',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  for (var i = 0; i < sessions.length; i++)
                    SessionTimelineTile(
                      session: sessions[i],
                      isLast: i == sessions.length - 1,
                      patientName: widget.patient.name,
                    ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}