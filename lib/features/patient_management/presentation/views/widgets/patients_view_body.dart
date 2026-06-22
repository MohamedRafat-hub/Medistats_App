import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';
import 'package:medistats/features/patient_management/presentation/managers/get_all_patients_cubit/get_all_patients_cubit.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_field.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_heading.dart';
import '../../../../../core/helper_functions/show_add_patient_bottom_sheet.dart';
import '../../../../../core/widgets/custom_floating_action_button.dart';
import 'app_title.dart';

class PatientsViewBody extends StatelessWidget {
  const PatientsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AppTitle(),
                      SizedBox(height: 16),
                      ScreenHeading(text: 'Patients'),
                      SizedBox(height: 16),
                      SearchField(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              PatientsListViewBuilder(),
            ],
          ),

          Positioned(
            right: 8,
            bottom: 24,
            child: BottomSheetButton(
              onTap: () {
                showAddPatientBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PatientsListViewBuilder extends StatelessWidget {
  const PatientsListViewBuilder({super.key});


  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      sliver: BlocBuilder<GetAllPatientsCubit, GetAllPatientsState>(
        builder: (context, state) {
          if(state is GetAllPatientsSuccess)
          {
            if(state.patients.isEmpty)
              {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No patients found.' , style: AppTextStyles.noPatient,),
                  ),
                );
              }
            return SliverList.builder(
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: (){
                      log(state.patients[index].id.toString());
                    },
                    child: PatientCard(
                      patientModel: state.patients[index],
                    ),
                  ),
                );
              },
            );
          }
          else if(state is GetAllPatientsLoading)
          {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
          else if(state is GetAllPatientsError)
          {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(state.message),
              ),
            );
          }
          else
          {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('No patients found.' , style: AppTextStyles.noPatient,),
              ),
            );
          }
        },
      ),
    );
  }
}