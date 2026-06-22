import 'package:bloc/bloc.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/patient_repo.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(this.patientRepo) : super(AddPatientInitial());
  final PatientRepo patientRepo;
  Future<void> addPatient(PatientModel patient)async {
    emit(AddPatientLoading());
   var result = await patientRepo.addPatient(patient);
   result.fold((errorMessage){
     emit(AddPatientFailure(errorMessage.message));
   }, (patientId){
      emit(AddPatientSuccess(patientId));
   });
  }
}
