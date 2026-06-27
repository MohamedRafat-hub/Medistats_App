import 'package:flutter/material.dart';
import 'package:medistats/core/models/patient_model.dart';
import '../../../../../core/utils/app_theme.dart';
import '../../../../patient_management/presentation/views/widgets/condition_page.dart';
import 'initials_avatar.dart';

/// Green summary card showing patient identity and condition badges.
/// Uses an initials avatar instead of a profile photo.
class PatientInfoCard extends StatelessWidget {
  final PatientModel patient;

  const PatientInfoCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final List<String> conditions = [
      if (patient.hasDiabetes ?? false) 'Diabetes',
      if (patient.hasHighBloodPressure ?? false) 'Hypertension',
    ];
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: conditions.map((condition) {
              final isDiabetes = condition == 'Diabetes';
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isDiabetes ? Colors.red[50] : Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDiabetes ? Colors.red[100]! : Colors.orange[100]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _iconForCondition(condition),
                      size: 16,
                      color: isDiabetes ? Colors.redAccent : Colors.orangeAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      condition,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDiabetes ? Colors.red[900] : Colors.orange[900],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _iconForCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'diabetes':
        return Icons.opacity;
      case 'hypertension':
        return Icons.speed_rounded;
      default:
        return Icons.health_and_safety_rounded;
    }
  }
}
