

import 'package:flutter/material.dart';

import 'package:medistats/features/patient_management/presentation/views/widgets/patients_list_view_builder.dart';
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

