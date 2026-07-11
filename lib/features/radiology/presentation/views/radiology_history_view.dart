import 'package:flutter/material.dart';
import 'widgets/radiology_history_view_body.dart';

class RadiologyHistoryView extends StatelessWidget {
  const RadiologyHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: RadiologyHistoryViewBody()),
    );
  }
}

