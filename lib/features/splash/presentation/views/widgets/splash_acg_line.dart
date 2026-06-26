import 'package:flutter/material.dart';
import 'package:medistats/features/splash/presentation/views/widgets/splash_acg_printer.dart';

class SplashEcgLine extends StatelessWidget {
  const SplashEcgLine({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Colors.transparent,
          Colors.white,
          Colors.white,
          Colors.transparent,
        ],
        stops: [0.0, 0.15, 0.85, 1.0],
      ).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomPaint(
          painter: SplashEcgPainter(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}