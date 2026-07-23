import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';

class PreviousXrayTile extends StatelessWidget {
  const PreviousXrayTile({
    super.key,
    required this.radiologyModel,
    this.onDelete,
    this.isDeleting = false,
  });

  final RadiologyModel radiologyModel;
  final VoidCallback? onDelete;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isDeleting ? 0.5 : 1.0,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: isDeleting
                ? null
                : () {
                    log("Navigate to radiology screen details");
                  },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image Section
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      radiologyModel.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: const Color(0xFFF1F5F9),
                        child: const Icon(
                          Icons.broken_image_outlined,
                          color: Color(0xFF94A3B8),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Details Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          radiologyModel.xrayType ?? 'Untitled X-ray',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                size: 11,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat(
                                'dd MMMM yyyy',
                              ).format(radiologyModel.uploadedAt),
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Delete Button Action
                  if (onDelete != null)
                    IconButton(
                      onPressed: isDeleting ? null : onDelete,
                      style: IconButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.all(8),
                      ),
                      icon: isDeleting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.redAccent,
                              ),
                            )
                          : Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red.shade300,
                              size: 22,
                            ),
                    ),

                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
