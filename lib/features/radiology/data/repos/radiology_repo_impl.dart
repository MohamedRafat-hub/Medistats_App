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

class RadiologyRepoImpl implements RadiologyRepo {
  final CloudinaryService cloudinaryService;
  final FireStoreService fireStoreService;
  final ImagePicker _picker = ImagePicker();

  RadiologyRepoImpl({
    required this.cloudinaryService,
    required this.fireStoreService,
  });

  @override
  Future<File?> captureXRay() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  @override
  Future<Either<Failure, String?>> uploadXRayImage(File imageFile) async {
    try {
      String? url = await cloudinaryService.uploadXRayImage(imageFile);
      if (url != null) {
        return right(url);
      } else {
        return left(ServerFailure("Failed to upload image to Cloudinary"));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadRadiology({
    required RadiologyModel radiologyModel,
  }) async {
    try {
      String uid = await fireStoreService.addData(
        collectionName: BackendEndpoint.radiology,
        data: radiologyModel.toJson(),
      );
      return right(uid);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(
        ServerFailure('An error occurred while uploading radiology.'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateRadiologyData({
    required RadiologyModel radiologyModel,
  }) async {
    try {
      await fireStoreService.updateDocument(
        collectionName: BackendEndpoint.radiology,
        docId: radiologyModel.id,
        data: radiologyModel.toJson(),
      );
      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(
        ServerFailure('An error occurred while updating radiology data.'),
      );
    }
  }

  @override
  Stream<Either<Failure, List<RadiologyModel>>> getPatientRadiologiesSession({
    required String sessionId,
  }) {
    return fireStoreService
        .getStreamCollection(
          collectionName: BackendEndpoint.radiology,
          whereField: 'sessionId',
          isEqualTo: sessionId,
          orderByField: 'uploadedAt',
        )
        .map<Either<Failure, List<RadiologyModel>>>((docs) {
          List<RadiologyModel> radiologies = docs
              .map((doc) => RadiologyModel.fromJson(doc.data(), doc.id))
              .toList();

          return right(radiologies);
        })
        .handleError((error) {
          if (error is FirebaseException) {
            return left(ServerFailure(error.message.toString()));
          } else {
            return left(ServerFailure(error));
          }
        });
  }

  @override
  Future<Either<Failure, List<RadiologyModel>>> getPatientRadiologies({
    required String patientId,
  }) async {
    try {
      final query = await fireStoreService.getFutureCollection(
        collectionName: BackendEndpoint.radiology,
        whereField: 'patientId',
        isEqualTo: patientId,
        orderByField: 'uploadedAt',
      );

      List<RadiologyModel> radiologies = query.docs.map<RadiologyModel>((doc) {
        return RadiologyModel.fromJson(doc.data(), doc.id);
      }).toList();

      return right(radiologies);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRadiology({
    required String radiologyId,
  }) async {
    try {
      await fireStoreService.deleteDocument(
        collectionName: BackendEndpoint.reports,
        docId: radiologyId,
      );
      return right(null);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
