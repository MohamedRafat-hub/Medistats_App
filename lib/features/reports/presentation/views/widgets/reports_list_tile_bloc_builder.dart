import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../../data/models/lab_report_model.dart';
import '../../managers/delete_report_cubit/delete_report_cubit.dart';
import 'delete_lab_report_item.dart';

class ReportsListTileBlocBuilder extends StatefulWidget {
  const ReportsListTileBlocBuilder({
    super.key,
    required this.reports,
  });

  final List<LabReportModel> reports;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  @override
  State<ReportsListTileBlocBuilder> createState() =>
      _ReportsListTileBlocBuilderState();
}

class _ReportsListTileBlocBuilderState
    extends State<ReportsListTileBlocBuilder> {

  String? deletingReportId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteReportCubit, DeleteReportState>(
      listener: (context, state) {
        if (state is DeleteReportLoading) {
        } else if (state is DeleteReportSuccess) {
          setState(() {
            deletingReportId = null;
          });
          showSnackBar(context, message: 'Lab report deleted successfully');
        } else if (state is DeleteReportError) {
          setState(() {
            deletingReportId = null;
          });

          showSnackBar(context, message: state.errorMessage , color: Colors.red);
        }
      },
      child: ListView.builder(
        itemCount: widget.reports.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final report = widget.reports[index];
          final isDeletingThis = deletingReportId == report.id;

          return DeletableReportItem(
            key: ValueKey(report.id),
            report: report,
            isDeleting: isDeletingThis,
            onDeleteRequested: () {
              _confirmAndDelete(context, report);
            },
          );
        },
      ),
    );
  }

  void _confirmAndDelete(BuildContext context, LabReportModel report) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Report',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to delete "${report.reportName}"? This action cannot be undone.',
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      setState(() {
        deletingReportId = report.id;
      });
      context.read<DeleteReportCubit>().deleteReport(reportId: report.id);
    }
  }
}