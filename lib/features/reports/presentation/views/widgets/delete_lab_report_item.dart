import 'package:flutter/material.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'report_tile.dart';

class DeletableReportItem extends StatefulWidget {
  const DeletableReportItem({
    super.key,
    required this.report,
    required this.isDeleting,
    required this.onDeleteRequested,
  });

  final LabReportModel report;
  final bool isDeleting;
  final VoidCallback onDeleteRequested;

  @override
  State<DeletableReportItem> createState() => _DeletableReportItemState();
}

class _DeletableReportItemState extends State<DeletableReportItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.isDeleting ? 0.4 : 1.0,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: widget.isDeleting
            ? const EdgeInsets.symmetric(vertical: 0)
            : const EdgeInsets.only(bottom: 12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ReportTileWidget(
              labReportModel: widget.report,
              onDelete: widget.isDeleting ? () {} : widget.onDeleteRequested,
            ),

            if (widget.isDeleting)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}