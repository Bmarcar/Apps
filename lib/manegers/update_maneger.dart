import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:apk_sideload/install_apk.dart';

class UpdateManager {
  final Dio _dio = Dio();

  Future<String> downloadApk({
    required String url,
    required void Function(double progress) onProgress,
  }) async {
    // Salva em armazenamento externo do app
    final dir = await getExternalStorageDirectory();

    if (dir == null) {
      throw Exception("Não foi possível acessar o armazenamento.");
    }

    final filePath = "${dir.path}/florida_update.apk";

    print("==================================");
    print("BAIXANDO APK");
    print("URL: $url");
    print("Destino: $filePath");
    print("==================================");

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

    print("==================================");
    print("DOWNLOAD FINALIZADO");
    print("Existe: ${file.existsSync()}");
    print("Tamanho: ${file.lengthSync()} bytes");
    print("==================================");

    return filePath;
  }

  Future<void> installApk(String filePath) async {
    final file = File(filePath);

    print("==================================");
    print("INICIANDO INSTALAÇÃO");
    print("Arquivo: ${file.path}");
    print("Existe: ${file.existsSync()}");
    print("Tamanho: ${file.lengthSync()} bytes");
    print("==================================");

    if (!file.existsSync()) {
      throw Exception("APK não encontrado.");
    }

    // Aguarda o Android terminar de liberar o arquivo
    await Future.delayed(const Duration(seconds: 2));

    try {
      await InstallApk().installApk(file.path);

      print("Instalador iniciado com sucesso.");

      // NÃO apagar o APK aqui.
      // O Android ainda pode estar lendo o arquivo.
    } catch (e, s) {
      print("==================================");
      print("ERRO AO INSTALAR");
      print(e);
      print(s);
      print("==================================");

      rethrow;
    }
  }
}
