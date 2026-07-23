import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';

import '../../../../../core/errors/failure.dart';

abstract class LabReportRepo {
  Future<Either<Failure, String>> uploadFileToStorage({required File file , required String patientId});

  Future<Either<Failure , String>> uploadLabReportData({required LabReportModel labReportModel});

  Stream<Either<Failure, List<LabReportModel>>> getSessionLabReport({required String sessionId});

  Stream<Either<Failure , List<LabReportModel>>> getPatientLabReports({required String patientId});

  Future<Either<Failure , void>> deleteLabReport({required String reportId});
}
