import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/patient_repo.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  final PatientRepo patientRepo;

  CancelableOperation? _currentOperation;

  AddPatientCubit(this.patientRepo) : super(AddPatientInitial());

  Future<void> addPatient(PatientModel patient) async {
    emit(AddPatientLoading());

    _currentOperation = CancelableOperation.fromFuture(
      patientRepo.addPatient(patient),
    );

    final result = await _currentOperation!.value;

    if (_currentOperation?.isCanceled ?? false) {
      emit(AddPatientInitial());
      return;
    }

    if (result != null) {
      result.fold(
            (errorMessage) => emit(AddPatientFailure(errorMessage.message)),
            (patientId) => emit(AddPatientSuccess(patientId)),
      );
    }
  }

  void cancelAddingPatient() {
    if (_currentOperation != null && !_currentOperation!.isCompleted) {
      _currentOperation!.cancel();
    }
  }
}
