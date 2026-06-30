import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class UpdateManager {
  final Dio _dio = Dio();

  static const MethodChannel _channel =
      MethodChannel('florida/update');

  Future<String> downloadApk({
    required String url,
    required void Function(double progress) onProgress,
  }) async {

    final dir = await getApplicationSupportDirectory();

    final filePath = "${dir.path}/florida_update.apk";

    print("================================");
    print("DOWNLOAD DO APK");
    print("URL: $url");
    print("Destino: $filePath");
    print("================================");

    await _dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );

    final file = File(filePath);

    print("================================");
    print("DOWNLOAD CONCLUÍDO");
    print("Existe: ${file.existsSync()}");
    print("Tamanho: ${file.lengthSync()} bytes");
    print("================================");

    return filePath;
  }

  Future<void> installApk(String filePath) async {

    final file = File(filePath);

    if (!file.existsSync()) {
      throw Exception("APK não encontrado.");
    }

    print("================================");
    print("INSTALANDO APK");
    print(file.path);
    print("================================");

    try {

      await _channel.invokeMethod(
        "installApk",
        file.path,
      );

      print("Instalador aberto.");

    } on PlatformException catch (e) {

      print("ERRO NATIVO");
      print(e.code);
      print(e.message);

      rethrow;
    }
  }
}