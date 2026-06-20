import 'package:flutter/material.dart';

import 'features/patient_management/presentation/views/patients_view.dart';

void main() => runApp(const MedistatsApp());

class MedistatsApp extends StatelessWidget {
  const MedistatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const PatientsView(),
    );
  }
}



/// Title at the top of the screen ("Medistats")

/// Section heading ("Patients")

/// Search input field

/// Card displaying a single patient's info

/// Small heart icon badge shown before condition text


/// Placeholder widget representing the vitals chart (no logic, static UI only)

/// Simple painter to draw a static heartbeat-like line (UI only, no real data)
class _VitalsLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final redPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final greenPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final redPath = Path()
      ..moveTo(0, size.height * 0.6)
      ..lineTo(size.width * 0.1, size.height * 0.6)
      ..lineTo(size.width * 0.15, size.height * 0.2)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.25, size.height * 0.5);

    final greenPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.5)
      ..lineTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width * 0.45, size.height * 0.1)
      ..lineTo(size.width * 0.5, size.height * 0.9)
      ..lineTo(size.width * 0.55, size.height * 0.5)
      ..lineTo(size.width * 0.7, size.height * 0.5)
      ..lineTo(size.width * 0.75, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.6)
      ..lineTo(size.width, size.height * 0.5);

    canvas.drawPath(redPath, redPaint);
    canvas.drawPath(greenPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Floating action button to add a new patient
