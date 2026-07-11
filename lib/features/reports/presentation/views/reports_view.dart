import 'package:flutter/material.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReportsViewBody(),
      )
    );
  }
}


class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
