
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../../../core/utils/app_theme.dart';
import '../../../../sessions/presentation/patient_history_view.dart';
import '../../../../sessions/presentation/views/widgets/patient_session.dart';
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
                    'No patients found.', style: AppTextStyles.noPatient,),
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
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          PatientHistoryView(patient: state.patients[index], sessions: [
                            PatientSession(
                              title: 'متابعة دورية للكشف',
                              dateLabel: '23 June 2026',
                              diagnosis: 'التهاب حاد في اللوزتين واحتقان بالحلق رفقة ارتفاع طفيف في درجات الحرارة.',
                              prescription: '1. شراب مضاد حيوي (Augmentin 457) - 5 مل كل 12 ساعة لمدة أسبوع.\n2. شراب خافض للحرارة (Cetal) - 5 مل عند اللزوم كل 6 ساعات.',
                              notes: 'يرجى الالتزام التام بجرعات المضاد الحيوي، وعمل كمادات مياه فلو الحرارة زادت عن 38.5، وإعادة الكشف بعد 5 أيام.',
                            ),
                            PatientSession(
                              title: 'متابعة دورية للكشف',
                              dateLabel: '23 June 2026',
                              diagnosis: 'التهاب حاد في اللوزتين واحتقان بالحلق رفقة ارتفاع طفيف في درجات الحرارة.',
                              prescription: '1. شراب مضاد حيوي (Augmentin 457) - 5 مل كل 12 ساعة لمدة أسبوع.\n2. شراب خافض للحرارة (Cetal) - 5 مل عند اللزوم كل 6 ساعات.',
                              notes: 'يرجى الالتزام التام بجرعات المضاد الحيوي، وعمل كمادات مياه فلو الحرارة زادت عن 38.5، وإعادة الكشف بعد 5 أيام.',
                            ),
                            PatientSession(
                              title: 'متابعة دورية للكشف',
                              dateLabel: '23 June 2026',
                              diagnosis: 'التهاب حاد في اللوزتين واحتقان بالحلق رفقة ارتفاع طفيف في درجات الحرارة.',
                              prescription: '1. شراب مضاد حيوي (Augmentin 457) - 5 مل كل 12 ساعة لمدة أسبوع.\n2. شراب خافض للحرارة (Cetal) - 5 مل عند اللزوم كل 6 ساعات.',
                              notes: 'يرجى الالتزام التام بجرعات المضاد الحيوي، وعمل كمادات مياه فلو الحرارة زادت عن 38.5، وإعادة الكشف بعد 5 أيام.',
                            ),
                          ]
                          )));
                    },
                    child: PatientCard(
                      patientModel: state.patients[index],
                    ),
                  ),
                );
              },
            );
          }
          else if (state is GetAllPatientsLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
          else if (state is GetAllPatientsError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(state.message),
              ),
            );
          }
          else {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No patients found.', style: AppTextStyles.noPatient,),
              ),
            );
          }
        },
      ),
    );
  }
}