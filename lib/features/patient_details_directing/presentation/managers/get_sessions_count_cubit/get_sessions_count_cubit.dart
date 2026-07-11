import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'get_sessions_count_state.dart';

class GetSessionsCountCubit extends Cubit<GetSessionsCountState> {
  GetSessionsCountCubit({required this.sessionsRepo}) : super(GetSessionsCountInitial());

  final SessionsRepo sessionsRepo;

  Future<void> getSessionsCount({required String patientId}) async {
    emit(GetSessionsCountLoading());

    var result = await sessionsRepo.getPatientSessionsCount(patientId: patientId);

    result.fold((error){
      log('GetSessionsCountCubit: ${error.toString()}');
      emit(GetSessionsCountError());
    }, (count) {
      emit(GetSessionsCountSuccess(count));
    });
  }
}
