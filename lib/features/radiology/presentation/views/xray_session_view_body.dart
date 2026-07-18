import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/latest_xray_card.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';

import '../managers/get_radiologies_cubit/get_patient_radiologies_cubit.dart';

class XraySessionViewBody extends StatelessWidget {
  const XraySessionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 100),
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
          final radiologies = state.radiologies;
          final int total = radiologies.length;

          if (total == 0) {
            return const _NoXraysYetState();
          }

          final RadiologyModel latest = radiologies.last;
          // Everything except the latest, so it isn't shown twice.
          final previousXrays = radiologies.sublist(0, total - 1);
          log(latest.uploadedAt.toString());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XraySummaryCard(
                imagesCount: total,
                lastUpdated: DateFormat('dd MMM').format(latest.uploadedAt),
              ),
              const SizedBox(height: 20),
              LatestXrayCard(
                imageUrl: latest.imageUrl,
                title: latest.xrayType ?? 'No title',
                dateLabel: DateFormat(
                  'dd MMMM yyyy',
                ).format(latest.uploadedAt),
              ),
              const SizedBox(height: 28),
              const Text(
                'Previous X-rays',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 14),
              previousXrays.isEmpty
                  ? const _NoPreviousXraysState()
                  : PreviousXraysList(previousXrays: previousXrays , isScrollable: false),
            ],
          );
        } else if (state is GetPatientRadiologiesSessionFailure) {
          log('Get radiologies failure ${state.errorMessage}');
          return _SessionErrorState(errorMessage: state.errorMessage);
        } else {
          return const _SessionErrorState(
            errorMessage: 'Something went wrong',
          );
        }
      },
    );
  }
}

class _NoXraysYetState extends StatelessWidget {
  const _NoXraysYetState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 40,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No X-rays in This Session',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the camera button to upload the first one',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoPreviousXraysState extends StatelessWidget {
  const _NoPreviousXraysState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Text(
          'No previous X-rays for this session yet',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SessionErrorState extends StatelessWidget {
  const _SessionErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 32,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}