import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/utils/backend_endpoint.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';

import '../../../../core/helper_functions/handle_firestore_errors.dart';

class PatientRepoImpl implements PatientRepo {
  final FireStoreService fireStoreService;

  PatientRepoImpl(this.fireStoreService);

  @override
  Future<Either<Failure, String>> addPatient(PatientModel patient) async {
    try {
      String uid = await fireStoreService.addData(collectionName: BackendEndpoint.patients, data: patient.toJson());
      return right(uid);
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure('عذراً، حدث خطأ غير متوقع في النظام. حاول مرة أخرى.'));
    }
  }

  @override
  Stream<Either<Failure, List<PatientModel>>> getAllPatients(){
    return fireStoreService
        .getCollection(
      collectionName: BackendEndpoint.patients,
      orderByField: 'createdAt',
    )
        .map<Either<Failure, List<PatientModel>>>((docs) {
      List<PatientModel> patients = docs.map((doc) => PatientModel.fromJson(doc.data(), doc.id)).toList();
      return right(patients);
    })
        .handleError((error) {
      // هندلة الأخطاء لو حصلت جوه الـ Stream
      return left(ServerFailure('حدث خطأ أثناء تحميل بيانات المرضى.'));
    });
  }

  @override
  Future<Either<Failure, void>> deletePatient(String patientId)async {
    try {
      await fireStoreService.deleteDocument(
        collectionName: BackendEndpoint.patients,
        docId: patientId,
      );
      return right(null); // unit تعني عملية ناجحة بدون داتا راجعة
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure('عذراً، فشل حذف المريض. حاول مرة أخرى.'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePatient(PatientModel patient)async {
    try {
      await fireStoreService.updateDocument(
        collectionName: BackendEndpoint.patients,
        docId: patient.id,
        data: patient.toJson(),
      );
      return right(null); // unit تعني عملية ناجحة بدون داتا راجعة
    } on FirebaseException catch (e) {
      return left(ServerFailure(handleFirebaseError(e)));
    } catch (e) {
      return left(ServerFailure('عذراً، فشل تحديث بيانات المريض. حاول مرة أخرى.'));
    }
  }




}