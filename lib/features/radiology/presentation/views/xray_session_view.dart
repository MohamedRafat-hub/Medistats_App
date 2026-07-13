import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/radiology/presentation/managers/upload_xray_cubit/upload_xray_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/upload_xray_bloc_listner.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/xray_session_app_bar.dart';

import '../../data/repos/radiology_repo.dart';
import 'xray_session_view_body.dart';

class XraySessionView extends StatelessWidget {
  const XraySessionView(
      {super.key, required this.patientId, required this.sessionId});

  final String patientId;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UploadXrayCubit(radiologyRepo: getIt.get<RadiologyRepo>()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: const XraySessionAppBar(
          patientName: 'Ahmed Mohamed',
          subtitle: 'Session X-ray Images',
        ),
        body: const XraySessionViewBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: UploadXrayBlocListener(
          patientId: patientId,
          sessionId: sessionId,
        ),
      ),
    );
  }
}


