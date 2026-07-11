import 'package:flutter/material.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/add_xray_button.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/xray_session_app_bar.dart';

import 'xray_session_view_body.dart';

class XraySessionView extends StatelessWidget {
  const XraySessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const XraySessionAppBar(
        patientName: 'Ahmed Mohamed',
        subtitle: 'Session X-ray Images',
      ),
      body: const XraySessionViewBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AddXrayButton(onPressed: () {}),
    );
  }
}
