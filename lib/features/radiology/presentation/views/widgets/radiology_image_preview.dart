import 'package:flutter/material.dart';

class RadiologyImagePreview extends StatelessWidget {
  final String imageUrl;

  const RadiologyImagePreview({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE2E8F0),
                child: const Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                  color: Color(0xFF94A3B8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}