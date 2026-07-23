import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/directing_view.dart';
import 'package:medistats/features/radiology/presentation/managers/update_radiology_details_cubit/update_radiology_details_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/radiology_details_edit_view.dart';
import 'package:medistats/features/radiology/presentation/views/radiology_history_view.dart';
import 'package:medistats/features/radiology/presentation/views/radiology_view.dart';
import 'package:medistats/features/reports/presentation/managers/get_lab_reports/get_lab_reports_cubit.dart';
import 'package:medistats/features/reports/presentation/managers/upload_lab_report_cubit/upload_lab_report_cubit.dart';
import 'package:medistats/features/reports/presentation/views/reports_session_view.dart';
import 'package:medistats/features/reports/presentation/views/reports_view.dart';
import 'package:medistats/features/sessions/presentation/patient_history_view.dart';

import '../../features/radiology/data/models/radiology_model.dart';
import '../../features/radiology/data/repos/radiology_repo.dart';
import '../../features/reports/data/repos/lab_report_repo.dart';
import '../../features/sessions/data/repos/sessions_repo.dart';
import '../../features/sessions/presentation/managers/get_patient_sessions_cubit/get_patient_sessions_cubit.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../services/getit_service.dart';

import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 1. Splash View (initialLocation: '/')
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashView(),
        );

      // 2. Directing View
      case '/directing':
        // Safe cast: settings.arguments replaces state.extra
        final patient = settings.arguments as PatientModel;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => DirectingView(patientModel: patient),
        );

      // 3. Sessions View (With BlocProvider Injection)
      case '/sessions':
        final patient = settings.arguments as PatientModel;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (_) =>
                GetPatientSessionsCubit(getIt.get<SessionsRepo>())
                  ..getPatientSessions(patientId: patient.id),
            child: PatientHistoryView(patient: patient),
          ),
        );

      case '/radiology':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              RadiologyHistoryView(patientName: settings.arguments as String),
        );

      case '/reports':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => GetLabReportsCubit(getIt.get<LabReportRepo>())
              ..getAllPatientReports(patientId: settings.arguments as String),
            child: ReportsView(),
          ),
        );

      case '/xray_session':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => RadiologyView(
            patientName: args['patientName']!,
            patientId: args['patientId']!,
            sessionId: args['sessionId']!,
          ),
        );

      case '/radiology_details':
        final radiologyModel = settings.arguments as RadiologyModel;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  UpdateRadiologyDetailsCubit(getIt.get<RadiologyRepo>()),
              child: RadiologyDetailsEditView(radiologyModel: radiologyModel),
            );
          },
        );

      case '/reports_session_view':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      UploadLabReportCubit(getIt.get<LabReportRepo>()),
                ),
                BlocProvider(
                  create: (context) =>
                      GetLabReportsCubit(getIt.get<LabReportRepo>())
                        ..getLabReports(sessionId: args['sessionId']!),
                ),
              ],
              child: ReportsSessionView(
                patientName: args['patientName']!,
                patientId: args['patientId']!,
                sessionId: args['sessionId']!,
              ),
            );
          },
        );
      // Fallback 404 Route
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
