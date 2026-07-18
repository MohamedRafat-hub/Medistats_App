import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/supabase_storage_service.dart';
import 'lab_report_repo.dart';

class LabReportRepoImpl implements LabReportRepo{
  final SupabaseStorageService supabaseStorageService;

  LabReportRepoImpl(this.supabaseStorageService);
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
}