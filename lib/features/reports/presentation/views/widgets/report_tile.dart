import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ReportTileWidget extends StatefulWidget {
  final String fileUrl;
  final String fileName;
  final String? date;

  const ReportTileWidget({
    super.key,
    required this.fileUrl,
    required this.fileName,
    this.date,
  });

  @override
  State<ReportTileWidget> createState() => _ReportTileWidgetState();
}

class _ReportTileWidgetState extends State<ReportTileWidget> {
  bool isLoading = false;
  double downloadProgress = 0.0;

  Future<void> _handlePdfOpen() async {
    setState(() {
      isLoading = true;
      downloadProgress = 0.0;
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      // تنظيف اسم الملف لتجنب أي مشاكل في المسارات
      final safeFileName = widget.fileName.replaceAll(RegExp(r'[^\w\.-]'), '_');
      final filePath = "${dir.path}/$safeFileName";
      final file = File(filePath);

      // 1. لو الملف متخزن محلياً نفتحه مباشرة (Cache)
      if (await file.exists()) {
        await OpenFilex.open(filePath);
      } else {
        // 2. تنزيل الملف بـ Dio
        final dio = Dio();
        await dio.download(
          widget.fileUrl,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                downloadProgress = received / total;
              });
            }
          },
        );
        await OpenFilex.open(filePath);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر فتح الملف: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: isLoading ? null : _handlePdfOpen,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // 1. أيقونة الملف الإحترافية
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Colors.red.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),

              // 2. اسم الملف والتاريخ
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      widget.fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.date != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.date!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // 3. حالة التحميل / زر الأكشن
              if (isLoading)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: downloadProgress > 0 ? downloadProgress : null,
                    strokeWidth: 2.5,
                    color: Colors.red.shade700,
                  ),
                )
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }
}