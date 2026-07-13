import 'package:flutter/material.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/latest_xray_card.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/previous_xrays_list.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_summary_card.dart';

class XraySessionViewBody extends StatelessWidget {
  const XraySessionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const XraySummaryCard(
            imagesCount: 4,
            lastUpdated: '12 Jul 2026',
          ),
          const SizedBox(height: 20),
          const LatestXrayCard(
            imageUrl:
                'https://images.unsplash.com/photo-1516069677018-378515003435?w=600',
            title: 'Chest X-Ray',
            dateLabel: 'Today',
          ),
          const SizedBox(height: 28),
          const Text(
            'Previous X-rays',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),
          const PreviousXraysList(),
        ],
      ),
    );
  }
}
