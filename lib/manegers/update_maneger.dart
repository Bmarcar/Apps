import 'dart:io';

import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';

class UpdateManager {
  final Dio _dio = Dio();

  Future<String> downloadApk({
    required String url,
    required void Function(double progress) onProgress,
  }) async {
    final dir = await getApplicationDocumentsDirectory();

    final filePath = "${dir.path}/florida_update.apk";

    await _dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );

    return filePath;
  }

  Future<void> installApk(String filePath) async {
    print("APK baixado em:");
    print(filePath);

    // Implementação temporária
  }
}
