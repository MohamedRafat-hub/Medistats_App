part of 'upload_lab_report_cubit.dart';

@immutable
sealed class UploadLabReportState {}

final class UploadLabReportInitial extends UploadLabReportState {}
final class UploadLabReportLoading extends UploadLabReportState {}
final class UploadLabReportSuccess extends UploadLabReportState {
  final String fileUrl;
  UploadLabReportSuccess(this.fileUrl);
}
final class UploadLabReportFailure extends UploadLabReportState {
  final String message;
  UploadLabReportFailure(this.message);
}
