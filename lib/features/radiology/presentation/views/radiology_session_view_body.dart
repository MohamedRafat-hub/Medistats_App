
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';


class RadiologyViewContent extends StatelessWidget {
  final List<RadiologyModel> radiologies;

  const RadiologyViewContent({
    super.key,
    required this.radiologies,
  });

  @override
  Widget build(BuildContext context) {
    if (radiologies.isEmpty) {
      return const _NoXraysYetState();
    }

    final latest = radiologies.last;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // 1. Summary Card
          if (radiologies.length > 1) ...[
            XraySummaryCard(
              imagesCount: radiologies.length,
              lastUpdated: DateFormat('dd MMM yyyy').format(latest.uploadedAt),
            ),
            const SizedBox(height: 24),
          ],

          // 2. Section Header
          const Text(
            'All X-rays & Radiology',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),

          PreviousXraysList(
            previousXrays: radiologies.reversed.toList(),
            isScrollable: false,
          ),
        ],
      ),
    );
  }
}

class _NoXraysYetState extends StatelessWidget {
  const _NoXraysYetState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 56,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No X-rays Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the camera button below to upload the first radiology scan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
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



