import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

class NoReportsFound extends StatelessWidget {
  const NoReportsFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Illustrated Icon with soft background
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.note_add_rounded,
                size: 64,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 24),

            // 2. Main Title
            Text(
              "No Reports Found",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // 3. Subtitle / Helper text
            Text(
              "Tap the button below to upload your first medical report",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}