import 'package:flutter/material.dart';

import '../../../data/models/radiology_model.dart';
import 'previous_xray_tile.dart';

class PreviousXraysList extends StatelessWidget {
  const PreviousXraysList({super.key, required this.previousXrays});

  final List<RadiologyModel> previousXrays;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: previousXrays.length,
      itemBuilder: (context, index) {
        return PreviousXrayTile(radiologyModel: previousXrays[index]);
      },
    );
  }
}
