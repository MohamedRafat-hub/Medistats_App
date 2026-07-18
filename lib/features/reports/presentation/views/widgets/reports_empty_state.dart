import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class ReportsEmptyState extends StatelessWidget {
  const ReportsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upload_file_outlined,
                size: 40,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No Lab Reports Yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the upload button to add the first report',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}