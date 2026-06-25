import 'package:dartz/dartz.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';

import '../../../../core/errors/failure.dart';

abstract class SessionsRepo {
  Future<Either<Failure, void>> addSession({
    required SessionModel sessionModel,
  });

  Stream<Either<Failure , List<SessionModel>>>getPatientAllSessions({required String patientId});
}
