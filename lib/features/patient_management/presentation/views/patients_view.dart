import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patients_view_body.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF1),
      body: PatientsViewBody(),
    );
  }
}

