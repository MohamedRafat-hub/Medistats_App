import 'package:flutter/material.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/widgets/directing_view_body.dart';

class DirectingView extends StatelessWidget {
  const DirectingView({super.key, required this.patientModel});

  final PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DirectingViewBody(patientModel: patientModel)),
    );
  }
}
