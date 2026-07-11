import 'package:flutter/material.dart';
import 'radiology_image_card.dart';

class RadiologyImagesGrid extends StatelessWidget {
  const RadiologyImagesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      children: const [
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/xray_1.png',
          date: 'May 05, 2026',
          type: 'X-ray',
        ),
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/ct_1.png',
          date: 'May 05, 2026',
          type: 'CT scan',
        ),
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/ct_2.png',
          date: 'May 05, 2026',
          type: 'CT scan',
        ),
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/ultrasound_1.png',
          date: 'May 05, 2026',
          type: 'Ultrasound',
        ),
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/ultrasound_2.png',
          date: 'May 05, 2026',
          type: 'Ultrasound',
        ),
        RadiologyImageCard(
          imageUrl: 'assets/images/radiology/ultrasound_3.png',
          date: 'May 05, 2026',
          type: 'Ultrasound',
        ),
      ],
    );
  }
}