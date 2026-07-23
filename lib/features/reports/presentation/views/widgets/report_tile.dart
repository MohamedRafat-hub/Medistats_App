import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/lab_report_model.dart';

class ReportTileWidget extends StatefulWidget {
  final LabReportModel labReportModel;
  final VoidCallback? onDelete; // 👈 Callback لزر الحذف

  const ReportTileWidget({
    super.key,
    required this.labReportModel,
    this.onDelete,
  });

  @override
  State<ReportTileWidget> createState() => _ReportTileWidgetState();
}

class _ReportTileWidgetState extends State<ReportTileWidget> {
  bool _isLoading = false;
  double _downloadProgress = 0.0;

  // 1. Helper logic for sanitizing file name and path
  Future<String> _getDestinationFilePath(String rawFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final sanitizedName = rawFileName.replaceAll(RegExp(r'[^\w\.-]'), '_');

    // إلحاق امتداد الملف إذا لم يكن موجوداً
    final hasExtension = sanitizedName.contains('.');
    final ext = widget.labReportModel.fileType == 'pdf' ? '.pdf' : '';
    final finalFileName = hasExtension ? sanitizedName : '$sanitizedName$ext';

    return "${dir.path}/$finalFileName";
  }

  // 2. Open / Download Logic
  Future<void> _handleFileOpen() async {
    final fileUrl = widget.labReportModel.fileUrl;
    final reportName = widget.labReportModel.reportName ?? 'Untitled_Report';

    if (fileUrl.isEmpty) return;

    setState(() {
      _isLoading = true;
      _downloadProgress = 0.0;
    });

    try {
      final filePath = await _getDestinationFilePath(reportName);
      final file = File(filePath);

      // Cache check
      if (await file.exists()) {
        await OpenFilex.open(filePath);
      } else {
        final dio = Dio();
        await dio.download(
          fileUrl,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1 && mounted) {
              setState(() {
                _downloadProgress = received / total;
              });
            }
          },
        );
        await OpenFilex.open(filePath);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open file: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = widget.labReportModel.fileType == "pdf";
    final reportName = widget.labReportModel.reportName ?? "Untitled Report";
    final uploadedAt = widget.labReportModel.uploadedAt;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: _isLoading ? null : _handleFileOpen,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Icon Section
                _ReportTypeAvatar(isPdf: isPdf),
                const SizedBox(width: 14),

                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reportName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      if (uploadedAt != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd MMMM yyyy').format(uploadedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Delete Action Button (Redesigned)
                if (widget.onDelete != null && !_isLoading) ...[
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: Colors.red.shade400,
                    ),
                    splashRadius: 20,
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                    tooltip: 'Delete Report',
                  ),
                  const SizedBox(width: 4),
                ],

                // Progress Indicator OR Arrow Action
                if (_isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: _downloadProgress > 0 ? _downloadProgress : null,
                      strokeWidth: 2.2,
                      color: AppColors.primaryColor,
                    ),
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: AppColors.primaryColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Private Sub-widget for cleaner build method
class _ReportTypeAvatar extends StatelessWidget {
  final bool isPdf;

  const _ReportTypeAvatar({required this.isPdf});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isPdf ? Icons.picture_as_pdf_outlined : Icons.image_outlined,
        size: 22,
        color: AppColors.primaryColor,
      ),
    );
  }
}