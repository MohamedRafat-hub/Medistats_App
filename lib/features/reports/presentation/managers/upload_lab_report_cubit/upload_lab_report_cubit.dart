import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'package:medistats/features/reports/data/repos/lab_report_repo.dart';
import 'package:meta/meta.dart';

part 'upload_lab_report_state.dart';

class UploadLabReportCubit extends Cubit<UploadLabReportState> {
  UploadLabReportCubit(this.labReportRepo) : super(UploadLabReportInitial());
  final LabReportRepo labReportRepo;

  Future<void> uploadLabReport(File file , LabReportModel labReportModel) async {
    emit(UploadLabReportLoading());

    var result = await labReportRepo.uploadFileToStorage(
      file: file,
      patientId: labReportModel.patientId,
    );

    result.fold(
      (error) {
        emit(UploadLabReportFailure(error.message));
      },
      (url)async {
        final UpdatedLabReportModel = labReportModel.copyWith(
          fileUrl: url,
        );
        var result =await labReportRepo.uploadLabReportData(labReportModel: UpdatedLabReportModel);
        result.fold((error){
          emit(UploadLabReportFailure(error.message));
        }, (id){
          final finalLabReportModel = UpdatedLabReportModel.copyWith(id: id);
          emit(UploadLabReportSuccess(finalLabReportModel));
        });
      },
    );
  }
}
