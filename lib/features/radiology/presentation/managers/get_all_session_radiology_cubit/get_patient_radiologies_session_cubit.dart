import 'package:bloc/bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:meta/meta.dart';

part 'get_patient_radiologies_session_state.dart';

class GetPatientRadiologiesSessionCubit extends Cubit<GetPatientRadiologiesSessionState> {
  GetPatientRadiologiesSessionCubit(this.radiologyRepo) : super(GetPatientRadiologiesSessionInitial());
  final RadiologyRepo radiologyRepo;

  void getPatientRadiologiesSession({required String sessionId}){
    emit(GetPatientRadiologiesSessionLoading());

    var request = radiologyRepo.getPatientRadiologiesSession(sessionId: sessionId);

    request.listen((result){
      result.fold((error){
        emit(GetPatientRadiologiesSessionFailure(error.message));
      }, (radiologies){
        emit(GetPatientRadiologiesSessionSuccess(radiologies));
      });
    });
  }
}
