import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<String> uploadFile({
    required File file,
    required String bucketName,
    required String path,
  }) async {
    try {

      final String extension = file.path.split('.').last.toLowerCase();
      String contentType = 'application/octet-stream';

      if (extension == 'pdf') {
        contentType = 'application/pdf';
      } else if (extension == 'png') {
        contentType = 'image/png';
      } else if (extension == 'jpg' || extension == 'jpeg') {
        contentType = 'image/jpeg';
      }

      await _supabaseClient.storage.from(bucketName).upload(
        path,
        file,
        fileOptions:  FileOptions(
          contentType: contentType,
          cacheControl: '3600',
          upsert: true,
        ),
      );

      final String publicUrl = _supabaseClient.storage.from(bucketName).getPublicUrl(path);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }
}