import 'package:flutter/material.dart';

import 'chronic_disease_item.dart';

class ChronicDiseasesSection extends StatelessWidget {
  const ChronicDiseasesSection({
    super.key,
    required this.hasDiabetes,
    required this.hasHighBloodPressure,
    required this.onDiabetesChanged,
    required this.onHypertensionChanged,
  });

  final bool hasDiabetes;
  final bool hasHighBloodPressure;
  final ValueChanged<bool> onDiabetesChanged;
  final ValueChanged<bool> onHypertensionChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChronicDiseaseItem(
          title: 'Diabetes',
          value: hasDiabetes,
          onChanged: onDiabetesChanged,
        ),
        const SizedBox(width: 16),
        ChronicDiseaseItem(
          title: 'Hypertension',
          value: hasHighBloodPressure,
          onChanged: onHypertensionChanged,
        ),
      ],
    );
  }
}
