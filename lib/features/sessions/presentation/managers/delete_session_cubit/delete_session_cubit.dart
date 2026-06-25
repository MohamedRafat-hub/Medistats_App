import 'package:bloc/bloc.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'delete_session_state.dart';

class DeleteSessionCubit extends Cubit<DeleteSessionState> {
  DeleteSessionCubit(SessionsRepo sessionsRepo) : _sessionsRepo = sessionsRepo, super(DeleteSessionInitial());
  final SessionsRepo _sessionsRepo;
  Future<void> deleteSession(String sessionId)async {
    emit(DeleteSessionLoading());
    var result =await _sessionsRepo.deleteSession(sessionId: sessionId);

    result.fold((error){
      emit(DeleteSessionFailure(error.toString()));
    }, (success) => emit(DeleteSessionSuccess()));
  }
}
