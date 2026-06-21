import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_field.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_heading.dart';
import 'package:medistats/features/sessions/presentation/patient_history_view.dart';

import '../../../../../core/helper_functions/show_add_patient_bottom_sheet.dart';
import '../../../../../core/widgets/custom_floating_action_button.dart';
import '../../../../sessions/presentation/views/widgets/patient.dart';
import '../../../../sessions/presentation/views/widgets/patient_session.dart';
import 'app_title.dart';

class PatientsViewBody extends StatelessWidget {
  const PatientsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            children: [
              AppTitle(),
              SizedBox(height: 16),
              ScreenHeading(text: 'Patients'),
              SizedBox(height: 16),
              SearchField(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PatientHistoryScreen(patient: Patient(
                          age: 64,
                          firstName: 'Hassan',
                          lastName: 'Ali',
                          phoneNumber: '010 1234 5678',
                          conditions: ['Diabetes']
                        ),  sessions: [
                          PatientSession(title: "باطنه", dateLabel: "${DateTime.now()}", diagnosis: "المريض يعناني من ألم حاد في المعده", prescription: "ياخد فيسرارجين", notes: "لا يوجد"),
                          PatientSession(title: "باطنه", dateLabel: "${DateTime.now().subtract(Duration(days: 30))}", diagnosis: "المريض يعناني من ألم حاد في المعده", prescription: "ياخد فيسرارجين", notes: "لا يوجد"),
                          PatientSession(title: "باطنه", dateLabel: "${DateTime.now().subtract(Duration(days: 30))}", diagnosis: "المريض يعناني من ألم حاد في المعده", prescription: "ياخد فيسرارجين", notes: "لا يوجد"),
                        ]);
                      },
                    ),
                  );
                },
                child: PatientCard(
                  name: 'Hassan Ali',
                  age: 64,
                  phone: '010 1234 5678',
                  condition: 'Diabetes',
                ),
              ),
              SizedBox(height: 16),
              PatientCard(
                name: 'Sanah Vanmi',
                age: 64,
                phone: '010 1234 5678',
                condition: 'Diabetes',
              ),
              SizedBox(height: 16),
              PatientCard(
                name: 'Hassan Ali',
                age: 64,
                phone: '010 1234 5678',
                condition: 'Diabetes',
              ),
            ],
          ),
          Positioned(
            right: 8,
            bottom: 24,
            child: BottomSheetButton(
              onTap: () {
                return showAddPatientBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
