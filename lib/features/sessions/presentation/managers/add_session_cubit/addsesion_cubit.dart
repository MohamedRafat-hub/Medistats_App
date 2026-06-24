import 'package:bloc/bloc.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'addsesion_state.dart';

class AddSessionCubit extends Cubit<AddSessionState> {
  AddSessionCubit(SessionsRepo sessionsRepo) : _sessionsRepo = sessionsRepo, super(AddSessionInitial());
  final SessionsRepo _sessionsRepo;
  Future<void>addSession({required SessionModel sessionModel})async{
    emit(AddSessionLoading());
    var result = await _sessionsRepo.addSession(sessionModel: sessionModel);

    result.fold((error){
      emit(AddSessionFailure(error.toString()));
    }, (_){
      emit(AddSessionSuccess());
    });
  }
}
