import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card_menue_button.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/presentation/managers/add_session_cubit/add_session_cubit.dart';
import 'package:medistats/features/sessions/presentation/managers/delete_session_cubit/delete_session_cubit.dart';
import 'package:medistats/features/sessions/presentation/managers/update_session_cubit/update_session_cubit.dart';
import '../../../../../core/utils/app_theme.dart';
import '../../../data/repos/sessions_repo.dart';
import 'add_session_bottom_sheet.dart';
import 'session_field_row.dart';

/// White rounded card showing a single visit/session summary:
/// title, date, diagnosis, prescription and notes.
class SessionCard extends StatelessWidget {
  final SessionModel session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy - hh:mm a').format(
        session.createdAt.toLocal());
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('متابعة دورية للكشف', style: AppTextStyles.sessionTitle),
              Spacer(),
              BlocListener<DeleteSessionCubit, DeleteSessionState>(
                listener: (context, state) {
                  log("state is : ${state.toString()}");
                  if (state is DeleteSessionSuccess) {
                    showSnackBar(
                        context, message: "Delete session successfully");
                  }
                  else if (state is DeleteSessionFailure) {
                    showSnackBar(context, message: state.errorMessage,
                        color: Colors.red);
                  }
                },
                child: BlocListener<UpdateSessionCubit, UpdateSessionState>(
                  listener: (context, state) {
                    if (state is UpdateSessionSuccess) {
                      showSnackBar(
                          context, message: "Update session successfully");
                    }
                    else if (state is UpdateSessionFailure) {
                      showSnackBar(context, message: state.errorMessage);
                    }
                  },
                  child: PatientCardMenuButton(
                    onDeletePressed: () {
                      log('Delete Session');
                      context.read<DeleteSessionCubit>().deleteSession(
                          session.sessionId);
                    },
                    onUpdatePressed: () {
                      log("Update Session");
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius
                              .circular(32)),
                        ),
                        builder: (modalContext) =>
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      UpdateSessionCubit(
                                          getIt.get<SessionsRepo>()),
                                ),
                                BlocProvider(
                                  create: (context) => AddSessionCubit(getIt.get<SessionsRepo>()),
                                ),
                              ],
                              child: AddSessionBottomSheet(
                                patientId: session.patientId,
                                sessionModel: session,
                              ),
                            ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(formattedDate, style: AppTextStyles.sessionDate),
          if (session.diagnosis.isNotEmpty ||
              session.prescription.isNotEmpty ||
              session.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            if (session.diagnosis.isNotEmpty)
              SessionFieldRow(label: 'Diagnosis', value: session.diagnosis),
            if (session.prescription.isNotEmpty) ...[
              const SizedBox(height: 10),
              SessionFieldRow(
                label: 'Prescription',
                value: session.prescription,
              ),
            ],
            if (session.notes.isNotEmpty) ...[
              const SizedBox(height: 10),
              SessionFieldRow(label: 'Notes', value: session.notes),
            ],
          ],
        ],
      ),
    );
  }
}
