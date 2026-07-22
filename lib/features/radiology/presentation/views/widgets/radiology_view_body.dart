import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_theme.dart';
import '../../managers/get_radiologies_cubit/get_patient_radiologies_cubit.dart';
import '../radiology_session_view_body.dart';

class RadiologyViewBody extends StatelessWidget {
  const RadiologyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRadiologiesCubit, GetRadiologiesState>(
      listener: (context, state) {
        if (state is GetPatientRadiologiesSessionFailure) {
          log('🔴 Get radiologies failure: ${state.errorMessage}');
        } else if (state is GetRadiologiesSuccess) {
          log('🟢 Success radiologies: ${state.radiologies.length}');
        }
      },
      builder: (context, state) {
        if (state is GetRadiologiesLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is GetRadiologiesSuccess) {
          return RadiologyViewContent(radiologies: state.radiologies);
        } else if (state is GetPatientRadiologiesSessionFailure) {
          return _SessionErrorState(errorMessage: state.errorMessage);
        }

        return const _SessionErrorState(
          errorMessage: 'Something went wrong while loading radiology scans',
        );
      },
    );
  }
}

class _SessionErrorState extends StatelessWidget {
  const _SessionErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}