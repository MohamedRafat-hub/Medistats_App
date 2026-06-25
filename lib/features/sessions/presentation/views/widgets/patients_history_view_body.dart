import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/sessions/presentation/managers/get_patient_sessions_cubit/get_patient_sessions_cubit.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_info_card.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/session_timeline_tile.dart';

class PatientsHistoryViewBody extends StatelessWidget {
  const PatientsHistoryViewBody({super.key, required this.patient});

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetPatientSessionsCubit, GetPatientSessionsState>(
        builder: (context, state) {

          if (state is GetPatientSessionsLoading) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                children: [
                  PatientInfoCard(patient: patient),
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
                  PatientInfoCard(patient: patient),
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
                PatientInfoCard(patient: patient),
                const SizedBox(height: 24),

                if (sessions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Center(
                      child: Text(
                        '.لا توجد جلسات مسجلة لهذا المريض بعد',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  for (var i = 0; i < sessions.length; i++)
                    SessionTimelineTile(
                      session: sessions[i],
                      isLast: i == sessions.length - 1,
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