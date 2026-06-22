part of 'get_all_patients_cubit.dart';

@immutable
sealed class GetAllPatientsState {}

final class GetAllPatientsInitial extends GetAllPatientsState {}
final class GetAllPatientsLoading extends GetAllPatientsState {}
final class GetAllPatientsSuccess extends GetAllPatientsState {
  final List<PatientModel> patients;
  GetAllPatientsSuccess(this.patients);
}
final class GetAllPatientsError extends GetAllPatientsState {
  final String message;

  GetAllPatientsError(this.message);
}
