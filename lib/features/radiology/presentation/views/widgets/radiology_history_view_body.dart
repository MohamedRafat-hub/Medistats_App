import 'package:flutter/material.dart';
import 'radiology_history_app_bar.dart';
import 'radiology_images_grid.dart';

class RadiologyHistoryViewBody extends StatelessWidget {
  const RadiologyHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RadiologyHistoryAppBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(child: RadiologyImagesGrid()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}