import 'package:flutter/material.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../../sessions/presentation/views/widgets/patient_info_card.dart';
import 'directing_widget.dart';

class DirectingViewBody extends StatelessWidget {
  const DirectingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 12,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PatientInfoCard(
            patient: PatientModel(
                id: "10",
                name: "Mohamed Rafat",
                age: 21,
                phoneNumber: "01011938448",
                createdAt: DateTime.now(),
                hasDiabetes: true,
                hasHighBloodPressure: true
            ),
          ),
        ),
        Expanded(
          child: DirectingWidget(
            image: 'assets/Icons/sessions.svg',
            title: 'Clinical Sessions',
            subTitle: "Sessions",
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