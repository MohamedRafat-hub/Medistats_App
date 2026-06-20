import 'package:flutter/material.dart';

import '../../features/patient_management/presentation/views/widgets/add_patient_bottom_sheet.dart';

void showAddPatientBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const AddPatientBottomSheet();
    },
  );
}
