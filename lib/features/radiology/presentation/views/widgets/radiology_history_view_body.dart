import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/presentation/managers/get_all_session_radiology_cubit/get_patient_radiologies_session_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'radiology_history_app_bar.dart';
import 'radiology_images_grid.dart';

class RadiologyHistoryViewBody extends StatelessWidget {
  const RadiologyHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RadiologyHistoryAppBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<GetRadiologiesCubit, GetRadiologiesState>(
                  builder: (context, state) {
                    return state is GetRadiologiesSuccess
                        ? PreviousXraysList(previousXrays: state.radiologies)
                        : state is GetPatientRadiologiesSessionFailure
                        ? Center(
                            child: Text(
                              'There was an Error occured ${state.errorMessage}',
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
