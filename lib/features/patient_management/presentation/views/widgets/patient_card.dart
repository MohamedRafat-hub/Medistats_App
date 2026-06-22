import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';
import 'package:medistats/features/patient_management/presentation/managers/delete_patient_cubit/delete_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card_menue_button.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/vitals_chart_placeholder.dart';
import 'condition_page.dart';

class PatientCard extends StatelessWidget {
  final PatientModel patientModel;

  const PatientCard({
    super.key,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: name + menu icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                patientModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              BlocListener<DeletePatientCubit, DeletePatientState>(
                listener: (context, state) {},
                child: PatientCardMenuButton(
                  onDeletePressed: () {
                    log("Delete button pressed for patient: ${patientModel
                        .name}");
                    Navigator.pop(context);
                    context.read<DeletePatientCubit>().deletePatient(
                        patientModel.id);
                  },
                ),
              ),
            ],
          ),
          Text(
            'Age: ${patientModel.age}',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                patientModel.phoneNumber,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              const ConditionBadge(),
              const SizedBox(width: 4),
              Text(
                "condition",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const VitalsChartPlaceholder(),
        ],
      ),
    );
  }
}



