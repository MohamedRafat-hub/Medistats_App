import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: BlocBuilder<GetRadiologiesCubit, GetRadiologiesState>(
              builder: (context, state) {
                if (state is GetRadiologiesSuccess) {
                  if (state.radiologies.isEmpty) {
                    return const _RadiologyHistoryEmptyState();
                  }
                  return PreviousXraysList(previousXrays: state.radiologies);
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.image_search_outlined,
              size: 36,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No X-rays Yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Uploaded X-ray images will appear here',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ],
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
              size: 36,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }
}