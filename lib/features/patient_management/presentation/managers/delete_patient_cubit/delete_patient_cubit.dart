import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/patient_repo.dart';

part 'delete_patient_state.dart';

class DeletePatientCubit extends Cubit<DeletePatientState> {
  final PatientRepo patientRepo;

  DeletePatientCubit(this.patientRepo) : super(DeletePatientInitial());

  Future<void> deletePatient(String patientId) async {
    emit(DeletePatientLoading());
    final result = await patientRepo.deletePatient(patientId);
    result.fold(
          (failure) => emit(DeletePatientFailure(failure.message)),
          (_) => emit(DeletePatientSuccess()),
    );
  }
}
