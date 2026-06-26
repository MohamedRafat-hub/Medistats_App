import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/core/widgets/custom_floating_action_button.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:medistats/features/sessions/presentation/managers/add_session_cubit/add_session_cubit.dart';
import 'package:medistats/features/sessions/presentation/managers/delete_session_cubit/delete_session_cubit.dart';
import 'package:medistats/features/sessions/presentation/managers/update_session_cubit/update_session_cubit.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/add_session_bottom_sheet.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_history_app_bar.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patients_history_view_body.dart';
import '../../../core/utils/app_theme.dart';


/// Screen showing a patient's profile summary and their session
/// history timeline. Pure UI — all data is passed in from outside.
class PatientHistoryView extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onAddSession;

  const PatientHistoryView({
    super.key,
    required this.patient,
    this.onAddSession,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteSessionCubit(getIt.get<SessionsRepo>()),
        ),
        BlocProvider(
          create: (context) => UpdateSessionCubit(getIt.get<SessionsRepo>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PatientHistoryAppBar(
          title: "${patient.name}'s History",
        ),
        floatingActionButton: BottomSheetButton(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (bottomSheetContext) {
                return BlocProvider(
                  create: (context) =>
                  (AddSessionCubit(getIt.get<SessionsRepo>())),
                  child: AddSessionBottomSheet(
                    patientId: patient.id,
                  ),
                );
              },
            );
          },
        ),
        body: PatientsHistoryViewBody(patient: patient),
      ),
    );
  }
}

