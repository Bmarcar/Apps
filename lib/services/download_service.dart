import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:apk_sideload/install_apk.dart';

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

  Future<void> installApk(String filePath) async {
    print("=== INSTALANDO APK ===");
    print(filePath);

    try {
      await InstallApk().installApk(filePath);

      print("Instalador iniciado.");
    } catch (e, s) {
      print("ERRO AO INSTALAR");
      print(e);
      print(s);

      rethrow;
    }
  }
}
