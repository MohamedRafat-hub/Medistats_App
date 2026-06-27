import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

class ChronicDiseaseItem extends StatelessWidget {
  const ChronicDiseaseItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Checkbox(
                value: value,
                activeColor: AppColors.primaryColor,
                onChanged: (newValue) => onChanged(newValue ?? false),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}