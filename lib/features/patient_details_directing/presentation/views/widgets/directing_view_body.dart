import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medistats/core/utils/constants.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../../sessions/presentation/views/widgets/patient_info_card.dart';
import 'directing_widget.dart';

class DirectingViewBody extends StatelessWidget {
  const DirectingViewBody({super.key, required this.patientModel});

  final PatientModel patientModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PatientInfoCard(
            patient: patientModel,
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/sessions.svg',
            title: 'Clinical Sessions',
            subTitle: "Sessions",
            onTap: (){
            },
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/xRay.svg',
            title: 'Radiology Gallery',
            subTitle: "Images",
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/reports.svg',
            title: 'Laboratory Reports',
            subTitle: "Reports",
          ),
        ),
      ],
    );
  }
}