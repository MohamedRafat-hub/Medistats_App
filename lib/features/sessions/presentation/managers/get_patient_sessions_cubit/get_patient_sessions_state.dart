part of 'get_patient_sessions_cubit.dart';

@immutable
sealed class GetPatientSessionsState {}

final class GetPatientSessionsInitial extends GetPatientSessionsState {}
final class GetPatientSessionsLoading extends GetPatientSessionsState {}
final class GetPatientSessionsSuccess extends GetPatientSessionsState {
  final List<SessionModel>sessions;

  GetPatientSessionsSuccess(this.sessions);
}
final class GetPatientSessionsFailure extends GetPatientSessionsState {
  final String error;
  GetPatientSessionsFailure(this.error);
}
