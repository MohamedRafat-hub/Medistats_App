part of 'get_patient_radiologies_session_cubit.dart';

@immutable
sealed class GetRadiologiesState {}

final class GetRadiologiesInitial extends GetRadiologiesState {}
final class GetRadiologiesLoading extends GetRadiologiesState {}
final class GetRadiologiesSuccess extends GetRadiologiesState {
  final List<RadiologyModel> radiologies;
  GetRadiologiesSuccess(this.radiologies);
}
final class GetPatientRadiologiesSessionFailure extends GetRadiologiesState {
  final String errorMessage;

  GetPatientRadiologiesSessionFailure(this.errorMessage);
}
