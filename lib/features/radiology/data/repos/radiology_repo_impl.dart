import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/cloudinary_storage_service.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/utils/backend_endpoint.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';

import '../../../../core/helper_functions/handle_firestore_errors.dart';

class RadiologyRepoImpl implements RadiologyRepo{
  final CloudinaryService cloudinaryService;
  final FireStoreService fireStoreService;
  final ImagePicker _picker = ImagePicker();
  RadiologyRepoImpl({required this.cloudinaryService, required this.fireStoreService});
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

  @override
  Future<Either<String, String>> uploadRadiology({required RadiologyModel radiologyModel})async {
    try {
      String uid = await fireStoreService.addData(collectionName: BackendEndpoint.radiology, data: radiologyModel.toJson());
      return right(uid);
    } on FirebaseException catch (e) {
      return left(handleFirebaseError(e));
    } catch (e) {
      return left('عذراً، حدث خطأ غير متوقع في النظام. حاول مرة أخرى.');
    }
  }


}