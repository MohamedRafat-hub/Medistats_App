import 'package:flutter/material.dart';

class RadiologyImagePreview extends StatelessWidget {
  final String imageUrl;

  const RadiologyImagePreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFF1F5F9),
                child: const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 44,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}