import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_card_menue_button.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_menue_options.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/vitals_chart_placeholder.dart';
import 'condition_page.dart';
class PatientCard extends StatelessWidget {
  final String name;
  final int age;
  final String phone;
  final String condition;

  const PatientCard({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.condition,
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
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const PatientCardMenuButton(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Age: $age',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                phone,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              const ConditionBadge(),
              const SizedBox(width: 4),
              Text(
                condition,
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



