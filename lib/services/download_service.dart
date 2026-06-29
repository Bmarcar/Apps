import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_android_package_installer/flutter_android_package_installer.dart';

class UpdateManager {
  final Dio _dio = Dio();

  Future<String> downloadApk({
    required String url,
    required void Function(double progress) onProgress,
  }) async {
    print("ENTREI NO DOWNLOAD SERVICE");

    print("================================");
    print(url);
    print("================================");

    final dir = await getApplicationDocumentsDirectory();

    print("DIRETÓRIO:");
    print(dir.path);

    final filePath = "${dir.path}/florida_update.apk";

    print("ARQUIVO:");
    print(filePath);

    try {
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress(received / total);
          }
        },
      );

      print("DOWNLOAD FINALIZADO");

      return filePath;
    } on DioException catch (e) {
      print("ERRO DIO");
      print(e.response?.statusCode);
      print(e.response?.data);
      print(e.message);
      rethrow;
    }
  }
}
