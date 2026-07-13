import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/presentation/managers/upload_xray_cubit/upload_xray_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/add_xray_button.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/xray_session_app_bar.dart';

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

class UploadXrayBlocListener extends StatelessWidget {
  const UploadXrayBlocListener({super.key, required this.patientId, required this.sessionId});
  final String patientId;
  final String sessionId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadXrayCubit, UploadXrayState>(
      listener: (context, state) {
        if (state is UploadXrayFailure) {
          showSnackBar(context, message: state.errorMessage, color: Colors.red);
        } else if (state is UploadXraySuccess) {
          showSnackBar(context, message: 'X-ray uploaded successfully');
        }
      },
      builder: (context, state) {
        return AddXrayButton(
          child: state is UploadXrayLoading
              ? CircularProgressIndicator(color: Colors.white)
              : const Icon(Icons.camera_alt_outlined, size: 24),
          onPressed: state is UploadXrayLoading ? () {} : () {
            final initialModel = RadiologyModel(id: '',
                imageUrl: '',
                uploadedAt: DateTime.now(),
                patientId: patientId,
                sessionId: sessionId);
            context.read<UploadXrayCubit>().uploadXRay(
              initialModel
            );
          },
        );
      },
    );
  }
}
