part of 'delete_patient_cubit.dart';

@immutable
sealed class DeletePatientState {}

final class DeletePatientInitial extends DeletePatientState {}
final class DeletePatientLoading extends DeletePatientState {}
final class DeletePatientSuccess extends DeletePatientState {}
final class DeletePatientFailure extends DeletePatientState {
  final String errorMessage;
  DeletePatientFailure(this.errorMessage);
}
