import 'package:flutter/material.dart';

import 'latest_badge.dart';

class LatestXrayCard extends StatelessWidget {
  const LatestXrayCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dateLabel,
  });

  final String imageUrl;
  final String title;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.05,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(
                    Icons.broken_image_outlined,
                    size: 40,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.45, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              right: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateLabel,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(right: 16, bottom: 16, child: LatestBadge()),
          ],
        ),
      ),
    );
  }
}