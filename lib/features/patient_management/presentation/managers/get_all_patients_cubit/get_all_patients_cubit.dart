import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';
import 'package:meta/meta.dart';

part 'get_all_patients_state.dart';

class GetAllPatientsCubit extends Cubit<GetAllPatientsState> {
  final PatientRepo patientRepo;
  StreamSubscription? _patientsSubscription;

  List<PatientModel> _allPatients = [];

  GetAllPatientsCubit(this.patientRepo) : super(GetAllPatientsInitial());

  void startListeningToPatients() {
    emit(GetAllPatientsLoading());

    _patientsSubscription?.cancel();

    _patientsSubscription = patientRepo.getAllPatients().listen((result) {
      result.fold((failure) => emit(GetAllPatientsError(failure.message)), (
        patients,
      ) {
        _allPatients = patients;
        emit(GetAllPatientsSuccess(patients));
      });
    });
  }


  void searchPatients(String query) {
    if (query.isEmpty) {
      emit(GetAllPatientsSuccess(_allPatients));
    } else {
      final filteredPatients = _allPatients.where((patient) {
        return patient.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(GetAllPatientsSuccess(filteredPatients));
    }
  }

  @override
  Future<void> close() {
    _patientsSubscription?.cancel();
    return super.close();
  }
}
