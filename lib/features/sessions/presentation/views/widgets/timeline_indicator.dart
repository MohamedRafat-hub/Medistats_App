import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

/// Vertical timeline indicator: a circular dot with a line extending
/// downward, used to connect consecutive session cards.
class TimelineIndicator extends StatelessWidget {
  final bool showLine;

  const TimelineIndicator({super.key, this.showLine = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            color: AppColors.cardGreenDark,
            shape: BoxShape.circle,
          ),
        ),
        if (showLine)
          Expanded(
            child: Container(
              width: 2,
              color: AppColors.timelineLine,
            ),
          ),
      ],
    );
  }
}
