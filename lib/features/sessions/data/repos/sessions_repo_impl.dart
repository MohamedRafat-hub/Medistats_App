import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/helper_functions/handle_firestore_errors.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/utils/backend_endpoint.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';

class SessionsRepoImpl implements SessionsRepo {
  final FireStoreService _fireStoreService;

  SessionsRepoImpl(this._fireStoreService);

  @override
  Future<Either<Failure, void>> addSession({
    required SessionModel sessionModel,
  })async {
    try {
     await  _fireStoreService.addData(
        collectionName: BackendEndpoint.sessions,
        data: sessionModel.toJson(),
      );
      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    }catch(e)
    {
      return left(ServerFailure(e.toString()));
    }
  }
}
