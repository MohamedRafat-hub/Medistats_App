import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/models/patient_model.dart';
import '../../../data/repos/patient_repo.dart';
part 'update_patient_state.dart';

class UpdatePatientCubit extends Cubit<UpdatePatientState> {
  UpdatePatientCubit(this.patientRepo) : super(UpdatePatientInitial());

  final PatientRepo patientRepo;

  Future<void> updatePatient({required PatientModel patient}) async {
    emit(UpdatePatientLoading());

    var result = await patientRepo.updatePatient(patient);
    result.fold(
      (failure) => emit(UpdatePatientFailure(failure.message)),
      (success) => emit(UpdatePatientSuccess()),
    );
  }
}
