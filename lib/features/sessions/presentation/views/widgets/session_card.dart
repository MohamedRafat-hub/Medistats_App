import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import '../../../../../core/utils/app_theme.dart';
import 'session_field_row.dart';

/// White rounded card showing a single visit/session summary:
/// title, date, diagnosis, prescription and notes.
class SessionCard extends StatelessWidget {
  final SessionModel session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy - hh:mm a').format(session.createdAt.toLocal());    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.title, style: AppTextStyles.sessionTitle),
          const SizedBox(height: 4),
          Text(formattedDate, style: AppTextStyles.sessionDate),
          if (session.diagnosis.isNotEmpty ||
              session.prescription.isNotEmpty ||
              session.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            if (session.diagnosis.isNotEmpty)
              SessionFieldRow(label: 'Diagnosis', value: session.diagnosis),
            if (session.prescription.isNotEmpty) ...[
              const SizedBox(height: 10),
              SessionFieldRow(
                label: 'Prescription',
                value: session.prescription,
              ),
            ],
            if (session.notes.isNotEmpty) ...[
              const SizedBox(height: 10),
              SessionFieldRow(label: 'Notes', value: session.notes),
            ],
          ],
        ],
      ),
    );
  }
}
