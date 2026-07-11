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
      children: const [],
    );
  }
}