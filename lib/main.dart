import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/patient_management/data/repos/patient_repo.dart';
import 'package:medistats/features/patient_management/presentation/managers/add_patient_cubit/add_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/managers/delete_patient_cubit/delete_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/managers/get_all_patients_cubit/get_all_patients_cubit.dart';
import 'package:medistats/features/patient_management/presentation/managers/update_patient_cubit/update_patient_cubit.dart';

import 'features/patient_management/presentation/views/patients_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  runApp(const MedistatsApp());
}

class MedistatsApp extends StatelessWidget {
  const MedistatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPatientCubit(getIt<PatientRepo>()),
        ),
        BlocProvider(create: (context) => GetAllPatientsCubit(getIt<PatientRepo>())..startListeningToPatients()),
        BlocProvider(create: (context) => DeletePatientCubit(getIt<PatientRepo>())),
        BlocProvider(create: (context) => UpdatePatientCubit(getIt<PatientRepo>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        home: const PatientsView(),
      ),
    );
  }
}
