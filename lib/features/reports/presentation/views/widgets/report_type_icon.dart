import 'package:flutter/material.dart';

class ReportTypeIcon extends StatelessWidget {
  const ReportTypeIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 22,
    this.padding = 10,
  });

  final IconData icon;
  final Color color;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size, color: color),
    );
  }
}