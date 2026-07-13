import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';

abstract class RadiologyRepo {
  Future<File?> captureXRay();
  Future<Either<Failure , String? >> uploadXRayImage(File imageFile);

  Future<Either<String , String>>uploadRadiology({required RadiologyModel radiologyModel});
}