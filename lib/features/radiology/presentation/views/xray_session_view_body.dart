import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/presentation/managers/get_all_session_radiology_cubit/get_patient_radiologies_session_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/latest_xray_card.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:medistats/features/sessions/presentation/managers/get_patient_sessions_cubit/get_patient_sessions_cubit.dart';

import '../../../../core/services/getit_service.dart';

class XraySessionViewBody extends StatelessWidget {
  const XraySessionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: DisplayRadiologySessionData(),
    );
  }
}

class DisplayRadiologySessionData extends StatelessWidget {
  const DisplayRadiologySessionData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRadiologiesCubit, GetRadiologiesState>(
      builder: (context, state) {
        if (state is GetRadiologiesLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        } else if (state is GetRadiologiesSuccess) {
          int lengthOfList = state.radiologies.length;
          RadiologyModel? lastRediologyModel;
          if (lengthOfList >= 1) {
            lastRediologyModel = state.radiologies.last;
            log(lastRediologyModel.uploadedAt.toString());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XraySummaryCard(
                imagesCount: state.radiologies.length,
                lastUpdated: '12 Jul',
              ),
              const SizedBox(height: 20),
              lengthOfList > 0 ?LatestXrayCard(
                imageUrl: lastRediologyModel!.imageUrl,
                title: lastRediologyModel?.xrayType ?? "No title",
                dateLabel: DateFormat(
                  'dd MMMM yyyy',
                ).format(lastRediologyModel.uploadedAt),
              ) : SizedBox(),
              const SizedBox(height: 28),
              lengthOfList > 1 ? Text(
                'Previous X-rays',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ) : Text(
                'No Previous X-rays Found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 14),
              state.radiologies.isEmpty
                  ? Center(
                      child: Text(
                        'No previous X-rays Found',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : lengthOfList > 1
                  ? PreviousXraysList(previousXrays: state.radiologies)
                  : SizedBox(),
            ],
          );
        } else if (state is GetPatientRadiologiesSessionFailure) {
          log('Get radiologies failure ${state.errorMessage}');
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
