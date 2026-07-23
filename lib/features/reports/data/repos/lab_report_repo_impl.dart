import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/services/supabase_storage_service.dart';
import 'package:medistats/core/utils/backend_endpoint.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'lab_report_repo.dart';

class LabReportRepoImpl implements LabReportRepo {
  final FireStoreService fireStoreService;
  final SupabaseStorageService supabaseStorageService;

  LabReportRepoImpl(this.supabaseStorageService, this.fireStoreService);

  @override
  Future<Either<Failure, String>> uploadFileToStorage({
    required File file,
    required String patientId,
  }) async {
    try {
      final String fileExtension = file.path.split('.').last;
      String contentType = 'application/$fileExtension';
      if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        contentType = 'image/jpeg';
      } else if (fileExtension == 'png') {
        contentType = 'image/png';
      }
      final int uniqueId = DateTime.now().millisecondsSinceEpoch;
      final String storagePath =
          'patients/$patientId/report_$uniqueId.$fileExtension';
      final fileUrl = await supabaseStorageService.uploadFile(
        file: file,
        bucketName: 'lab_reports',
        path: storagePath,
        contentType: contentType,
      );
      return right(fileUrl);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadLabReportData({
    required LabReportModel labReportModel,
  }) async {
    try {
      var result = await fireStoreService.addData(
        collectionName: BackendEndpoint.reports,
        data: labReportModel.toJson(),
      );
      return right(result);
    } on FirebaseException catch (e) {
      return left(ServerFailure(e.message ?? e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<LabReportModel>>> getSessionLabReport({
    required String sessionId,
  }) async* {
    final stream = fireStoreService.getStreamCollection(
      collectionName: BackendEndpoint.reports,
      whereField: 'sessionId',
      isEqualTo: sessionId,
      orderByField: 'uploadedAt',
    );

    try {
      await for (final docs in stream) {
        try {
          final reports = docs
              .map((doc) => LabReportModel.fromJson(doc.data(), doc.id))
              .toList();
          yield right(reports);
        } catch (e) {
          yield left(ServerFailure('خطأ في تحويل البيانات: ${e.toString()}'));
        }
      }
    } on FirebaseException catch (e) {
      yield left(ServerFailure(e.message ?? e.toString()));
    } catch (e) {
      yield left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<LabReportModel>>> getPatientLabReports({
    required String patientId,
  }) async* {

      var stream = await fireStoreService.getStreamCollection(
        collectionName: BackendEndpoint.reports,
        whereField: 'patientId',
        isEqualTo: patientId,
        orderByField: 'uploadedAt',
      );

      try {
        await for (final docs in stream)
          {
            try {
              List<LabReportModel> reports = docs
                  .map((doc) => LabReportModel.fromJson(doc.data(), doc.id))
                  .toList();
              log("The id of the patient to get all reports is $patientId");
              yield right(reports);
            }catch (e) {
              yield left(ServerFailure('خطأ في تحويل البيانات: ${e.toString()}'));
            }
          }
      } on FirebaseException catch (e) {
        yield left(ServerFailure(e.message ?? e.toString()));
      }catch(e)
    {
      yield left(ServerFailure(e.toString()));
    }


  }

  @override
  Future<Either<Failure, void>> deleteLabReport({
    required String reportId,
  }) async {
    try {
      await fireStoreService.deleteDocument(
        collectionName: BackendEndpoint.reports,
        docId: reportId,
      );

      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(e.message ?? e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
