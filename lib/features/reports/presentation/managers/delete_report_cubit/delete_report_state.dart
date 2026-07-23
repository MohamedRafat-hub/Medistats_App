part of 'delete_report_cubit.dart';

@immutable
sealed class DeleteReportState {}

final class DeleteReportInitial extends DeleteReportState {}
final class DeleteReportLoading extends DeleteReportState {}
final class DeleteReportSuccess extends DeleteReportState {}
final class DeleteReportError extends DeleteReportState {
  final String errorMessage;
  DeleteReportError(this.errorMessage);
}
