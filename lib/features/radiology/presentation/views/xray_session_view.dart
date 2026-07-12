import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/radiology/presentation/managers/upload_xray_cubit/upload_xray_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/add_xray_button.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/views/widgets/xray_session_app_bar.dart';

import '../../data/radiology_repo.dart';
import 'xray_session_view_body.dart';

class XraySessionView extends StatelessWidget {
  const XraySessionView({super.key});

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
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat,
        floatingActionButton: UploadXrayBlocListener(),
      ),
    );
  }
}

class UploadXrayBlocListener extends StatelessWidget {
  const UploadXrayBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadXrayCubit, UploadXrayState>(
      listener: (context, state) {
        if(state is UploadXraySuccess)
          {
            showSnackBar(context, message: "Upload photo successfully");
          }
        else if(state is UploadXrayFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
      },
      child: AddXrayButton(onPressed: () {
        context.read<UploadXrayCubit>().captureXRay();
      }),
    );
  }
}
