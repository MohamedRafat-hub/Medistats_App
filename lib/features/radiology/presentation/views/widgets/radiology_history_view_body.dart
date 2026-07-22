import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/radiology_history_content.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';
import '../../../data/models/radiology_model.dart';
import '../../managers/get_radiologies_cubit/get_patient_radiologies_cubit.dart';
import 'radiology_history_app_bar.dart';

class RadiologyHistoryViewBody extends StatelessWidget {
  const RadiologyHistoryViewBody({super.key, required this.patientName});

  final String patientName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadiologyHistoryAppBar(patientName: patientName),
        Expanded(
          child: BlocBuilder<GetRadiologiesCubit, GetRadiologiesState>(
            builder: (context, state) {
              if (state is GetRadiologiesSuccess) {
                if (state.radiologies.isEmpty) {
                  return const _RadiologyHistoryEmptyState();
                }
                return RadiologyHistoryContent(
                  radiologies: state.radiologies,
                );
              } else if (state is GetPatientRadiologiesSessionFailure) {
                return _RadiologyHistoryErrorState(
                  errorMessage: state.errorMessage,
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}





class _RadiologyHistoryEmptyState extends StatelessWidget {
  const _RadiologyHistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                Icons.image_search_outlined,
                size: 40,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No History Found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Uploaded X-ray images for this patient will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadiologyHistoryErrorState extends StatelessWidget {
  const _RadiologyHistoryErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 38,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to Load History',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}