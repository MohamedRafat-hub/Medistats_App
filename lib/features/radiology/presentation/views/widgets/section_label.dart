import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 0.6,
      ),
    );
  }
}