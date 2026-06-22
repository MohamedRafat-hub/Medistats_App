part of 'add_patient_cubit.dart';

@immutable
sealed class AddPatientState {}

final class AddPatientInitial extends AddPatientState {}
final class AddPatientLoading extends AddPatientState {}
final class AddPatientSuccess extends AddPatientState {
  final String patientId;

  AddPatientSuccess(this.patientId);
}
final class AddPatientFailure extends AddPatientState {
  final String errorMessage;
  AddPatientFailure(this.errorMessage);
}
