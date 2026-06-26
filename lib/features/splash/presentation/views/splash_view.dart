import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/patient_management/presentation/views/patients_view.dart';
import '../manager/splash_cubit/splash_cubit.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..navigateToHome(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PatientsView()),
          );
        },
        child: Scaffold(body: SplashViewBody()),
      ),
    );
  }
}
