import 'package:flutter/material.dart';

class RadiologyImageCard extends StatelessWidget {
  const RadiologyImageCard({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.type,
  });

  final String imageUrl;
  final String date;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(date, style: const TextStyle(fontSize: 13)),
                  Text(
                    type,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}