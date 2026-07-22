import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';

import '../../../data/models/radiology_model.dart';

class RadiologyHistoryContent extends StatelessWidget {
  final List<RadiologyModel> radiologies;

  const RadiologyHistoryContent({
    super.key,
    required this.radiologies,
  });

  @override
  Widget build(BuildContext context) {
    final latest = radiologies.last;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // 1. Summary Card
          XraySummaryCard(
            imagesCount: radiologies.length,
            lastUpdated: DateFormat('dd MMM yyyy').format(latest.uploadedAt),
          ),
          const SizedBox(height: 24),

          // 2. Title Section
          const Text(
            'All Patient X-rays & Radiology',
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