import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:meta/meta.dart';

part 'get_patient_radiologies_session_state.dart';

class GetPatientRadiologiesSessionCubit extends Cubit<GetPatientRadiologiesSessionState> {
  GetPatientRadiologiesSessionCubit(this.radiologyRepo) : super(GetPatientRadiologiesSessionInitial());

  final RadiologyRepo radiologyRepo;

  StreamSubscription? _streamSubscription;
  void getPatientRadiologiesSession({required String sessionId})
  {
    emit(GetPatientRadiologiesSessionLoading());

    _streamSubscription?.cancel();

    final request = radiologyRepo.getPatientRadiologiesSession(sessionId: sessionId);

   _streamSubscription =  request.listen((result){
      result.fold((error){
        print("🔴 Radiology Stream Error: ${error.message}");
        emit(GetPatientRadiologiesSessionFailure(error.message));
      }, (radiologies){
        print("🟢 Radiology Stream Success! Items count: ${radiologies.length}"); // 👈 وضيف ده
        emit(GetPatientRadiologiesSessionSuccess(radiologies));
      });
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}