import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:meta/meta.dart';

part 'get_patient_radiologies_state.dart';

class GetRadiologiesCubit extends Cubit<GetRadiologiesState> {
  GetRadiologiesCubit(this.radiologyRepo) : super(GetRadiologiesInitial());

  final RadiologyRepo radiologyRepo;

  StreamSubscription? _streamSubscription;

  int numOfRadiologies = 0;
  void getPatientRadiologiesSession({required String sessionId})
  {
    emit(GetRadiologiesLoading());

    _streamSubscription?.cancel();

    final request = radiologyRepo.getPatientRadiologiesSession(sessionId: sessionId);

   _streamSubscription =  request.listen((result){
      result.fold((error){
        log("🔴 Radiology Stream Error: ${error.message}");
        emit(GetPatientRadiologiesSessionFailure(error.message));
      }, (radiologies){
        log("🟢 Radiology Stream Success! Items count: ${radiologies.length}"); // 👈 وضيف ده
        emit(GetRadiologiesSuccess(radiologies));
      });
    });
  }

  Future<void> getAllPatientRadiologies({required String patientId}) async
  {
    emit(GetRadiologiesLoading());

    var result =await radiologyRepo.getPatientRadiologies(patientId: patientId);

    result.fold((error){
      log("🔴 Radiology Stream Error: ${error.message}");
      emit(GetPatientRadiologiesSessionFailure(error.message));
    }, (radiologies){
      numOfRadiologies = radiologies.length;
      log("🟢 Radiology Stream Success! Items count: ${radiologies.length}");
      emit(GetRadiologiesSuccess(radiologies));
    });
  }



  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}