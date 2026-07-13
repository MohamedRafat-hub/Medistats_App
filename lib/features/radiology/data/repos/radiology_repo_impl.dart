import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/cloudinary_storage_service.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';

class RadiologyRepoImpl implements RadiologyRepo{
  final CloudinaryService cloudinaryService;
  final ImagePicker _picker = ImagePicker();
  RadiologyRepoImpl({required this.cloudinaryService});
  @override
  Future<File?> captureXRay() async{
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<Either<Failure, String?>> uploadXRayImage(File imageFile)async {
    try {
      String? url =  await cloudinaryService.uploadXRayImage(imageFile);
      if(url != null) {
        return right(url);
      }
      else
        {
          return left(ServerFailure("Failed to upload image to Cloudinary"));
        }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}