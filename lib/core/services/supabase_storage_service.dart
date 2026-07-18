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
      await _supabaseClient.storage.from(bucketName).upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true,
        ),
      );

      final String publicUrl = _supabaseClient.storage.from(bucketName).getPublicUrl(path);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload file to Supabase Storage: ${e.toString()}');
    }
  }
}