import 'dart:io';

import 'package:supabase/supabase.dart';

enum UploadType { avatar }

abstract class UploadRepository {
  Future<String> upload(
      {required String bucket,
      required File file,
      required UploadType uploadType});
}

class UploadRepositoryImpl extends UploadRepository {
  final SupabaseClient supabase;

  UploadRepositoryImpl(this.supabase);

  @override
  Future<String> upload(
      {required String bucket,
      required File file,
      required UploadType uploadType}) async {
    await supabase.storage.createBucket(bucket);
    final String path = await supabase.storage.from(bucket).upload(
          'private/${file.path.split('/').last}',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    return path;
  }
}
