import 'package:bloc/bloc.dart';
import 'package:medistats/features/reports/data/repos/lab_report_repo.dart';
import 'package:meta/meta.dart';

part 'delete_report_state.dart';

class DeleteReportCubit extends Cubit<DeleteReportState> {
  DeleteReportCubit(this.labReportRepo) : super(DeleteReportInitial());

  final LabReportRepo labReportRepo;

  Future<void> deleteReport({required String reportId}) async
  {
    emit(DeleteReportLoading());

    var result = await labReportRepo.deleteLabReport(reportId: reportId);

    result.fold((error) =>
        emit(DeleteReportError(error.message)), (success) =>
        emit(DeleteReportSuccess()));
  }
