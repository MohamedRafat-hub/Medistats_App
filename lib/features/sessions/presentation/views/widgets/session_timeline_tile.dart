import 'package:flutter/material.dart';
import 'package:medistats/features/sessions/presentation/views/widgets/patient_session.dart';
import 'session_card.dart';
import 'timeline_indicator.dart';

/// Combines a [TimelineIndicator] with a [SessionCard] to form one
/// row of the vertical session history timeline.
class SessionTimelineTile extends StatelessWidget {
  final PatientSession session;
  final bool isLast;

  const SessionTimelineTile({
    super.key,
    required this.session,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimelineIndicator(showLine: !isLast),
            const SizedBox(width: 12),
            Expanded(child: SessionCard(session: session)),
          ],
        ),
      ),
    );
  }
}
