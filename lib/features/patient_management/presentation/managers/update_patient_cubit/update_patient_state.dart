part of 'update_patient_cubit.dart';

@immutable
sealed class UpdatePatientState {}

final class UpdatePatientInitial extends UpdatePatientState {}
final class UpdatePatientLoading extends UpdatePatientState {}
final class UpdatePatientSuccess extends UpdatePatientState {}
final class UpdatePatientFailure extends UpdatePatientState {
  final String errorMessage;
  UpdatePatientFailure(this.errorMessage);
}
