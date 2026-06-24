import 'package:flutter/material.dart';
import 'package:medistats/core/models/patient_model.dart';
import '../../../../../core/utils/app_theme.dart';
import 'initials_avatar.dart';

/// Green summary card showing patient identity and condition badges.
/// Uses an initials avatar instead of a profile photo.
class PatientInfoCard extends StatelessWidget {
  final PatientModel patient;

  const PatientInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InitialsAvatar(
                name: patient.name,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: AppTextStyles.patientName,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Age: ${patient.age}',
                      style: AppTextStyles.patientSubInfo,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      patient.phoneNumber,
                      style: AppTextStyles.patientSubInfo,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Wrap(
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: [
          //     for (final condition in patient.conditions)
          //       ConditionBadge(
          //         label: condition,
          //         icon: _iconForCondition(condition),
          //       ),
          //   ],
          // ),
        ],
      ),
    );
  }

  IconData _iconForCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'diabetes':
        return Icons.favorite;
      case 'hypertension':
        return Icons.bolt;
      default:
        return Icons.medication;
    }
  }
}
