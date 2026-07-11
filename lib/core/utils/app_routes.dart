import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/core/utils/constants.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/directing_view.dart';
import 'package:medistats/features/radiology/presentation/views/radiology_history_view.dart';
import 'package:medistats/features/reports/presentation/views/reports_view.dart';
import 'package:medistats/features/sessions/presentation/patient_history_view.dart';

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
          builder: (context) => RadiologyHistoryView(),
        );

      case '/reports':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ReportsView()
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
