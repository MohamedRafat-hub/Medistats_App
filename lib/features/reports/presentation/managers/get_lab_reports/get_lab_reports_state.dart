part of 'get_lab_reports_cubit.dart';

@immutable
sealed class GetLabReportsState {
  const GetLabReportsState();

  @override
  List<Object?> get props => [];
}

final class GetLabReportsInitial extends GetLabReportsState {}
final class GetLabReportsLoading extends GetLabReportsState {}
final class GetLabReportsSuccess extends GetLabReportsState {
  final List<LabReportModel> reports;

  const GetLabReportsSuccess(this.reports);

  @override
  List<Object?> get props => [reports];
}
final class GetLabReportsError extends GetLabReportsState {
  final String errorMessage;

  const GetLabReportsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
