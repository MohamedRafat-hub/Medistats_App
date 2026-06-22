import 'package:get_it/get_it.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FireStoreService>(FireStoreService());
  getIt.registerSingleton<PatientRepo>(PatientRepoImpl(getIt.get<FireStoreService>()));
}