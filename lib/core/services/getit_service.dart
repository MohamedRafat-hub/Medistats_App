import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:medistats/core/services/cloudinary_storage_service.dart';
import 'package:medistats/core/services/firestore_service.dart';
import 'package:medistats/core/services/supabase_storage_service.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo_impl.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo_impl.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo.dart';
import 'package:medistats/features/sessions/data/repos/sessions_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FireStoreService>(FireStoreService());
  getIt.registerSingleton<PatientRepo>(
    PatientRepoImpl(getIt.get<FireStoreService>()),
  );
  getIt.registerSingleton<SessionsRepo>(
    SessionsRepoImpl(getIt.get<FireStoreService>()),
  );
  getIt.registerSingleton<CloudinaryService>(CloudinaryService());
  getIt.registerSingleton<RadiologyRepo>(
    RadiologyRepoImpl(cloudinaryService: getIt.get<CloudinaryService>(), fireStoreService: getIt.get<FireStoreService>()),
  );

  getIt.registerSingleton<SupabaseStorageService>(SupabaseStorageService());
}
