import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card.dart';
import '../../../../../core/utils/app_theme.dart';
import '../../managers/get_all_patients_cubit/get_all_patients_cubit.dart';

class PatientsListViewBuilder extends StatelessWidget {
  const PatientsListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      sliver: BlocBuilder<GetAllPatientsCubit, GetAllPatientsState>(
        builder: (context, state) {
          if (state is GetAllPatientsSuccess) {
            if (state.patients.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'No patients found.',
                    style: AppTextStyles.noPatient,
                  ),
                ),
              );
            }
            return SliverList.builder(
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      log(state.patients[index].id.toString());
                      Navigator.pushNamed(
                        context,
                        '/directing',
                        arguments: state.patients[index], // Passes your PatientModel
                      );
                    },
                    child: PatientCard(patientModel: state.patients[index]),
                  ),
                );
              },
            );
          } else if (state is GetAllPatientsLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is GetAllPatientsError) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.message)),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No patients found.',
                  style: AppTextStyles.noPatient,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
