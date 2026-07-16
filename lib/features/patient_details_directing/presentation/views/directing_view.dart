import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/patient_details_directing/presentation/managers/get_sessions_count_cubit/get_sessions_count_cubit.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/widgets/directing_view_body.dart';
import 'package:medistats/features/radiology/presentation/managers/get_radiologies_cubit/get_patient_radiologies_cubit.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';

import '../../../radiology/data/repos/radiology_repo.dart';

class DirectingView extends StatelessWidget {
  const DirectingView({super.key, required this.patientModel});

  final PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  GetSessionsCountCubit(sessionsRepo: getIt.get<SessionsRepo>())
                    ..getSessionsCount(patientId: patientModel.id),
            ),
            BlocProvider(
              create: (context) =>
                  GetRadiologiesCubit(getIt.get<RadiologyRepo>())
                    ..getAllPatientRadiologies(patientId: patientModel.id),
            ),
          ],
          child: DirectingViewBody(patientModel: patientModel),
        ),
      ),
    );
  }
}
