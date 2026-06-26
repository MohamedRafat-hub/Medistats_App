import 'package:flutter/material.dart';

/// Draws a static ECG / heartbeat line across the full width.
/// Used as the visual signature of Medistats on the splash screen.
class SplashEcgPainter extends CustomPainter {
  final Color color;

  const SplashEcgPainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..lineTo(size.width * 0.12, size.height * 0.5)
      ..lineTo(size.width * 0.17, size.height * 0.3)

      ..lineTo(size.width * 0.20, size.height * 0.5)
      ..lineTo(size.width * 0.28, size.height * 0.5)

      ..lineTo(size.width * 0.33, size.height * 0.5)
      ..lineTo(size.width * 0.36, size.height * 0.05)
      ..lineTo(size.width * 0.39, size.height * 0.95)
      ..lineTo(size.width * 0.42, size.height * 0.5)

      ..lineTo(size.width * 0.50, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.55, size.height * 0.15,
        size.width * 0.60, size.height * 0.5,
      )

      ..lineTo(size.width * 0.70, size.height * 0.5)

      ..lineTo(size.width * 0.74, size.height * 0.36)
      ..lineTo(size.width * 0.76, size.height * 0.20)
      ..lineTo(size.width * 0.78, size.height * 0.80)
      ..lineTo(size.width * 0.80, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.84, size.height * 0.28,
        size.width * 0.88, size.height * 0.5,
      )
      ..lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}