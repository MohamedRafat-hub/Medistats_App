import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/core/widgets/show_deleted_confirmation_bottom_sheet.dart';
import 'package:medistats/features/patient_management/presentation/managers/delete_patient_cubit/delete_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card_menue_button.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/vitals_chart_placeholder.dart';
import 'add_patient_bottom_sheet.dart';
import 'chronic_disease_badge.dart';

class PatientCard extends StatelessWidget {
  final PatientModel patientModel;

  const PatientCard({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
    final bool hasDiabetes = patientModel.hasDiabetes ?? false;
    final bool hasHypertension = patientModel.hasHighBloodPressure ?? false;
    final bool hasAnyChronicDisease = hasDiabetes || hasHypertension;

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
                    showDeleteConfirmationBottomSheet(
                      isPatientDelete: true,
                      context,
                      onConfirm: () {
                        context.read<DeletePatientCubit>().deletePatient(
                          patientModel.id,
                        );
                      },
                    );
                    log("Delete button pressed for patient: ${patientModel.name}");
                  },
                  onUpdatePressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddPatientBottomSheet(patientToEdit: patientModel),
                    );
                  },
                ),
              ),
            ],
          ),
          Text(
            'Age: ${patientModel.age}',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Text(
                'Phone: ${patientModel.phoneNumber}',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(width: 12),
            ],
          ),
          if (hasAnyChronicDisease) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                if (hasDiabetes)
                  const ChronicDiseaseBadge(
                    label: 'Diabetes',
                    icon: Icons.opacity,
                  ),
                if (hasDiabetes && hasHypertension) const SizedBox(width: 8),
                if (hasHypertension)
                  const ChronicDiseaseBadge(
                    label: 'Hypertension',
                    icon: Icons.favorite, // أيقونة قلب معبرة عن الضغط
                  ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          const VitalsChartPlaceholder(),
        ],
      ),
    );
  }
}
