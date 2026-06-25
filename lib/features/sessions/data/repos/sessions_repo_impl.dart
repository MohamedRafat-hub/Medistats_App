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
  }) async {
    try {
      await _fireStoreService.addData(
        collectionName: BackendEndpoint.sessions,
        data: sessionModel.toJson(),
      );
      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<SessionModel>>> getPatientAllSessions({
    required String patientId,
  }) {
    return _fireStoreService
        .getCollection(
          collectionName: BackendEndpoint.sessions,
          orderByField: 'createdAt',
          whereField: 'patientId',
          isEqualTo: patientId,
          descending: false,
        )
        .map<Either<Failure, List<SessionModel>>>((docs) {
          List<SessionModel> sessions = docs
              .map((doc) => SessionModel.fromJson(doc.data(), doc.id))
              .toList();
          return right(sessions);
        })
        .handleError((error) {
          if (error is FirebaseException) {
            return left(ServerFailure(handleFirebaseError(error)));
          }
          return ServerFailure(error.toString());
        });
  }

  @override
  Future<Either<Failure, void>> deleteSession({
    required String sessionId,
  }) async {
    try {
      await _fireStoreService.deleteDocument(
        collectionName: BackendEndpoint.sessions,
        docId: sessionId,
      );

      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
