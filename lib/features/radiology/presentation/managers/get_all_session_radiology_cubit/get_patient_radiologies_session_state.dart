part of 'get_patient_radiologies_session_cubit.dart';

@immutable
sealed class GetPatientRadiologiesSessionState {}

final class GetPatientRadiologiesSessionInitial extends GetPatientRadiologiesSessionState {}
final class GetPatientRadiologiesSessionLoading extends GetPatientRadiologiesSessionState {}
final class GetPatientRadiologiesSessionSuccess extends GetPatientRadiologiesSessionState {
  final List<RadiologyModel> radiologies;
  GetPatientRadiologiesSessionSuccess(this.radiologies);
}
final class GetPatientRadiologiesSessionFailure extends GetPatientRadiologiesSessionState {
  final String errorMessage;

  GetPatientRadiologiesSessionFailure(this.errorMessage);
}
