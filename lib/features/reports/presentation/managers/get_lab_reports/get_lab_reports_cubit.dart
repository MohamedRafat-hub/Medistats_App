import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import '../../../data/repos/lab_report_repo.dart';

part 'get_lab_reports_state.dart';

class GetLabReportsCubit extends Cubit<GetLabReportsState> {
  GetLabReportsCubit(this.labReportRepo) : super(GetLabReportsInitial());

  final LabReportRepo labReportRepo;
  StreamSubscription? _streamSubscription;

  void getLabReports({required String sessionId}) {
    emit(GetLabReportsLoading());

    _streamSubscription?.cancel();

    _streamSubscription = labReportRepo
        .getSessionLabReport(sessionId: sessionId)
        .listen((result) {
          if (isClosed) return;

          result.fold(
            (error) => emit(GetLabReportsError(error.message)),
            (reports) => emit(GetLabReportsSuccess(reports)),
          );
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Future<void> getAllPatientReports({required String patientId}) async {
    emit(GetLabReportsLoading());

    var result = await labReportRepo.getPatientLabReports(patientId: patientId);

    result.fold((error){
      emit(GetLabReportsError(error.message));
    }, (reports) => emit(GetLabReportsSuccess(reports)));
  }
}
