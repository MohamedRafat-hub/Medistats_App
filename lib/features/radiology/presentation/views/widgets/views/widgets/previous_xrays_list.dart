import 'package:flutter/material.dart';

import 'previous_xray_tile.dart';

class PreviousXraysList extends StatelessWidget {
  const PreviousXraysList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PreviousXrayTile(
          thumbnailUrl:
              'https://images.unsplash.com/photo-1584982751601-97dcc096659c?w=200',
          title: 'Right Arm Fracture',
          dateLabel: '15 Jun 2026',
        ),
        SizedBox(height: 14),
        PreviousXrayTile(
          thumbnailUrl:
              'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?w=200',
          title: 'Left Knee Joint',
          dateLabel: '02 Mar 2026',
        ),
        SizedBox(height: 14),
        PreviousXrayTile(
          thumbnailUrl:
              'https://images.unsplash.com/photo-1584555684040-bad07f46a21f?w=200',
          title: 'Dental Panoramic',
          dateLabel: '10 Nov 2025',
        ),
      ],
    );
  }
}
