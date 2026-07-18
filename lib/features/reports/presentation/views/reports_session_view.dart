import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/reports/presentation/managers/upload_lab_report_cubit/upload_lab_report_cubit.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_session_view_body.dart';
import 'widgets/reports_session_app_bar.dart';
import 'widgets/upload_report_button.dart';

class ReportsSessionView extends StatelessWidget {
  const ReportsSessionView({
    super.key,
    required this.patientName,
    required this.patientId,
  });

  final String patientName;
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: ReportsSessionAppBar(patientName: patientName),
      body: const ReportsSessionViewBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
          BlocConsumer<UploadLabReportCubit, UploadLabReportState>(
            listener: (context, state) {
              if (state is UploadLabReportSuccess) {
                log(state.fileUrl.toString());
                showSnackBar(context, message: 'Upload report successfully and link is ${state.fileUrl}');
              } else if (state is UploadLabReportFailure) {
                log("Upload error is ${state.message}");
                showSnackBar(
                  context,
                  message: state.message,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return UploadReportButton(
                widget: state is UploadLabReportLoading
                    ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                    : Icon(Icons.upload_file_outlined, size: 24),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                  );

                  if (result != null && result.files.single.path != null) {
                    File selectedFile = File(result.files.single.path!);
                    context.read<UploadLabReportCubit>().uploadLabReport(
                      selectedFile,
                      patientId,
                    );
                  }
                },
              );
            },
          ),
    );
  }
}
