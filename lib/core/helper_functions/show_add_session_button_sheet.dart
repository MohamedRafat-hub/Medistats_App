import 'package:flutter/material.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/add_session_bottom_sheet.dart';

import '../../features/patient_management/presentation/views/widgets/add_patient_bottom_sheet.dart';


void showAddSessionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const AddSessionBottomSheet();
    },
  );
}
