import 'package:flutter/material.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/widgets/directing_view_body.dart';
class DirectingView extends StatelessWidget {
  const DirectingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: DirectingViewBody()));
  }
}




