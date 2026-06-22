import 'package:bloc/bloc.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';
import 'package:meta/meta.dart';
part 'get_all_patients_state.dart';

class GetAllPatientsCubit extends Cubit<GetAllPatientsState> {
  GetAllPatientsCubit(this.patientRepo) : super(GetAllPatientsInitial());
  final PatientRepo patientRepo;

  Future<void> getAllPatients() async {
    emit(GetAllPatientsLoading());

    var result = await patientRepo.getAllPatients();
    result.fold((error) {
      emit(GetAllPatientsError(error.message));
    }, (patients) {
      emit(GetAllPatientsSuccess(patients));
    });
  }
}
