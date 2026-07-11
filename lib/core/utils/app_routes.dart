import 'package:go_router/go_router.dart';
import 'package:medistats/core/models/patient_model.dart';
import 'package:medistats/core/utils/constants.dart';
import 'package:medistats/features/patient_details_directing/presentation/views/directing_view.dart';

import '../../features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: Constants.splashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/directing',
      name: Constants.directingView,
      builder: (context, state) =>
          DirectingView(patientModel: state.extra as PatientModel),
    ),
  ],
);
