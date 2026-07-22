import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<void> openPdfFromUrl({
  required String url,
  required String fileName,
}) async {
  try {
    // 1. تحديد المسار المحالي للحفظ
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/$fileName.pdf";
    final file = File(filePath);

    // 2. التشييك: لو الملف اتنزل قبل كدا نفتحه على طول زي الواتساب
    if (await file.exists()) {
      await OpenFilex.open(filePath);
      return;
    }

    // 3. لو مش موجود.. هننزله بـ Dio
    final dio = Dio();
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          // هنا تقدر تعرض نسبة التنزيل في الـ UI لو حابب
          final progress = (received / total * 100).toStringAsFixed(0);
          print("Downloading: $progress%");
        }
      },
    );

    // 4. فتح الملف بعد مكتمل التنزيل
    await OpenFilex.open(filePath);

  } catch (e) {
    print("Error opening PDF: $e");
  }
}