import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medistats/core/utils/constants.dart';
import 'package:medistats/features/patient_details_directing/presentation/managers/get_sessions_count_cubit/get_sessions_count_cubit.dart';
import 'package:medistats/features/sessions/presentation/managers/get_patient_sessions_cubit/get_patient_sessions_cubit.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../../sessions/presentation/views/widgets/patient_info_card.dart';
import 'directing_widget.dart';

class DirectingViewBody extends StatelessWidget {
  const DirectingViewBody({super.key, required this.patientModel});

  final PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PatientInfoCard(patient: patientModel),
        ),
        Expanded(
          child: BlocBuilder<GetSessionsCountCubit, GetSessionsCountState>(
            builder: (context, state) {
              log(state.toString());
              log('The sessions count is ${state is GetSessionsCountSuccess ? state.count : 0}');
              return DirectingWidget(
                itemNumbers: state is GetSessionsCountSuccess ? state.count : 0,
                image: 'assets/Icons/sessions.svg',
                title: 'Clinical Sessions',
                subTitle: "Sessions",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/sessions',
                    arguments: patientModel,
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/xRay.svg',
            title: 'Radiology Gallery',
            subTitle: "Images",
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/reports.svg',
            title: 'Laboratory Reports',
            subTitle: "Reports",
          ),
        ),
      ],
    );
  }
}
