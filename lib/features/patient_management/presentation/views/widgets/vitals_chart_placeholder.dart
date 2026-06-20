import 'package:flutter/material.dart';

class VitalsChartPlaceholder extends StatelessWidget {
  const VitalsChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              size: const Size(double.infinity, 50),
              painter: _VitalsLinePainter(),
            ),
          ),
          const Text(
            'ulta',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black45,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}



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
