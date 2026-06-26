import 'package:flutter/material.dart';
import 'package:medistats/features/splash/presentation/views/widgets/splah_loading_indicator.dart';
import 'package:medistats/features/splash/presentation/views/widgets/splash_acg_line.dart';
import 'package:medistats/features/splash/presentation/views/widgets/splash_tegline.dart';
import 'splash_app_name.dart';
import 'splash_logo_icon.dart';


class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A5568),
            Color(0xFF2C7A8C),
            Color(0xFF3A9BB0),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),

              const SplashLogoIcon(),

              const SizedBox(height: 28),

              const SplashAppName(),

              const SizedBox(height: 10),

              const SplashTagline(),

              const Spacer(flex: 2),

              const SplashEcgLine(),

              const Spacer(flex: 2),

              const SplashLoadingIndicator(),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
