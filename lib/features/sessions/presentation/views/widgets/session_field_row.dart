import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

/// Displays a label above its value, e.g. "Diagnosis" / "T2 Diabetes flare-up".
class SessionFieldRow extends StatelessWidget {
  final String label;
  final String value;

  const SessionFieldRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.fieldValue),
      ],
    );
  }
}
