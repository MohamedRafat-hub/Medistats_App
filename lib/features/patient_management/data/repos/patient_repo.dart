import 'package:dartz/dartz.dart';
import 'package:medistats/core/errors/failure.dart';
import 'package:medistats/features/patient_management/data/models/patient_model.dart';

abstract class PatientRepo {
  Future<Either<Failure ,String>>addPatient(PatientModel patient);
  Stream<Either<Failure , List<PatientModel>>>getAllPatients();
  Future<Either<Failure ,void>>deletePatient(String patientId);
}