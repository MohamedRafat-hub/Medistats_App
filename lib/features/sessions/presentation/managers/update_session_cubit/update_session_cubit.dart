import 'package:bloc/bloc.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:meta/meta.dart';

part 'update_session_state.dart';

class UpdateSessionCubit extends Cubit<UpdateSessionState> {
  UpdateSessionCubit(SessionsRepo sessionsRepo)
    : _sessionsRepo = sessionsRepo,
      super(UpdateSessionInitial());

  final SessionsRepo _sessionsRepo;

  Future<void> updateSession(SessionModel sessionModel) async {
    emit(UpdateSessionLoading());
    var result = await _sessionsRepo.updateSession(sessionModel: sessionModel);

    if (isClosed) return;
    result.fold(
      (error) => emit(UpdateSessionFailure(error.message)),
      (success) => emit(UpdateSessionSuccess()),
    );
  }
}
