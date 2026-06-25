import 'dart:developer';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'add_session_state.dart';

class AddSessionCubit extends Cubit<AddSessionState> {
  AddSessionCubit(SessionsRepo sessionsRepo) : _sessionsRepo = sessionsRepo, super(AddSessionInitial());
  final SessionsRepo _sessionsRepo;

  CancelableOperation? cancelableOperation;
  Future<void>addSession({required SessionModel sessionModel})async{
    emit(AddSessionLoading());

    cancelableOperation = CancelableOperation.fromFuture(
      _sessionsRepo.addSession(sessionModel: sessionModel),
    );

    final result = await cancelableOperation!.value;

    if(cancelableOperation?.isCanceled ?? false) return;

    result.fold((error){
      emit(AddSessionFailure(error.toString()));
    }, (_){
      emit(AddSessionSuccess());
    });
  }

  void cancelAddingSession() {
    if (cancelableOperation != null && !cancelableOperation!.isCanceled) {
      cancelableOperation!.cancel();
      emit(AddSessionInitial());
      log("تم إلغاء رفع الجلسة بنجاح قبل وصولها للسيرفر 😎");
    }
  }
}
