import 'package:flutter/material.dart';

class RadiologyView extends StatelessWidget {
  const RadiologyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RadiologyViewBody(),
      )
    );
  }
}



class RadiologyViewBody extends StatelessWidget {
  const RadiologyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
