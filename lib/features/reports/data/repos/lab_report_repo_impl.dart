import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/services/supabase_storage_service.dart';
import 'package:medistats/core/utils/backend_endpoint.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'lab_report_repo.dart';

class LabReportRepoImpl implements LabReportRepo{
  final FireStoreService fireStoreService;
  final SupabaseStorageService supabaseStorageService;
  LabReportRepoImpl(this.supabaseStorageService, this.fireStoreService);
  @override
  Future<Either<Failure, String>> uploadFileToStorage({required File file , required String patientId})async {
    try {
      final String fileExtension = file.path.split('.').last;
      final int uniqueId = DateTime.now().millisecondsSinceEpoch;
      final String storagePath = 'patients/$patientId/report_$uniqueId.$fileExtension';

      final fileUrl = await supabaseStorageService.uploadFile(file: file, bucketName: 'lab_reports', path: storagePath);
      return right(fileUrl);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadLabReportData({required LabReportModel labReportModel})async {
    try {
      var result = await fireStoreService.addData(collectionName: BackendEndpoint.reports, data: labReportModel.toJson());
      return right(result);
    } on FirebaseException catch (e) {
      return left(ServerFailure(e.message ?? e.toString()));
    }
    catch(e)
    {
      return left(ServerFailure(e.toString()));
    }
  }
}