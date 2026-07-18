import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:medistats/features/reports/data/repos/lab_report_repo.dart';
import 'package:meta/meta.dart';

part 'upload_lab_report_state.dart';

class UploadLabReportCubit extends Cubit<UploadLabReportState> {
  UploadLabReportCubit(this.labReportRepo) : super(UploadLabReportInitial());
  final LabReportRepo labReportRepo;

  Future<void> uploadLabReport(File file, String patientId) async {
    emit(UploadLabReportLoading());

    var result = await labReportRepo.uploadFileToStorage(
      file: file,
      patientId: patientId,
    );

    result.fold(
      (error) {
        emit(UploadLabReportFailure(error.message));
      },
      (url) {
        emit(UploadLabReportSuccess(url));
      },
    );
  }
}
