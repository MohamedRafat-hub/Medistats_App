import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medistats/core/errors/failure.dart';

abstract class RadiologyRepo {
  Future<File?> captureXRay();
  Future<Either<Failure , String? >> uploadXRayImage(File imageFile);
}