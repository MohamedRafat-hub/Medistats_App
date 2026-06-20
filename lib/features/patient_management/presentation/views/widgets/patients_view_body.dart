import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_field.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/search_heading.dart';

import '../../../../../core/helper_functions/show_add_patient_bottom_sheet.dart';
import '../../../../../core/widgets/custom_floating_action_button.dart';
import 'app_title.dart';

class PatientsViewBody extends StatelessWidget {
  const PatientsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            children: const [
              AppTitle(),
              SizedBox(height: 16),
              ScreenHeading(text: 'Patients'),
              SizedBox(height: 16),
              SearchField(),
              SizedBox(height: 20),
              PatientCard(
                name: 'Hassan Ali',
                age: 64,
                phone: '010 1234 5678',
                condition: 'Diabetes',
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
            child: AddPatientButton(
              onTap: (){
                return showAddPatientBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}