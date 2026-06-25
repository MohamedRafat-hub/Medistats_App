import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'get_patient_sessions_state.dart';

class GetPatientSessionsCubit extends Cubit<GetPatientSessionsState> {
  GetPatientSessionsCubit(SessionsRepo sessionsRepo) : _sessionsRepo = sessionsRepo, super(GetPatientSessionsInitial());

  final SessionsRepo _sessionsRepo;
  StreamSubscription? _sessionsSubscription;
  void getPatientSessions({required String patientId}){
    emit(GetPatientSessionsLoading());

    _sessionsSubscription?.cancel();
    
    _sessionsSubscription = _sessionsRepo.getPatientAllSessions(patientId: patientId).listen((result){
      result.fold((error){
        emit(GetPatientSessionsFailure(error.toString()));
      }, (sessions){
        emit(GetPatientSessionsSuccess(sessions));
      });
    });
  }
}
