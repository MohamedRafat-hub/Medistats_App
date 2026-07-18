import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class LabReportRepo {
  Future<Either<Failure, String>> uploadFileToStorage({required File file , required String patientId});
}
