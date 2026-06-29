import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_version.dart';

class UpdateService {
  final _supabase = Supabase.instance.client;

  Future<AppVersion?> getLatestVersion() async {
    print("=== CONSULTANDO SUPABASE ===");

    final response = await _supabase
        .from('app_versions')
        .select()
        .order('created_at', ascending: false)
        .limit(1);

    print(response);

    if ((response as List).isEmpty) {
      print("Tabela vazia");
      return null;
    }

    return AppVersion.fromMap(response.first);
  }

  Future<String> getInstalledVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  bool _isNewerVersion(String installed, String latest) {
    final current = installed.split('.').map(int.parse).toList();
    final server = latest.split('.').map(int.parse).toList();

    while (current.length < server.length) {
      current.add(0);
    }

    while (server.length < current.length) {
      server.add(0);
    }

    for (int i = 0; i < current.length; i++) {
      if (server[i] > current[i]) return true;
      if (server[i] < current[i]) return false;
    }

    return false;
  }

  Future<AppVersion?> checkForUpdate() async {
    final info = await PackageInfo.fromPlatform();

    print("=== VERIFICANDO ATUALIZAÇÃO ===");
    print("Versão instalada: ${info.version}");
    print("Build: ${info.buildNumber}");

    final latest = await getLatestVersion();

    if (latest == null) {
      print("Nenhuma versão encontrada no servidor.");
      return null;
    }

    print("Versão do servidor: ${latest.version}");

    final installed = info.version;

    if (_isNewerVersion(installed, latest.version)) {
      print("ATUALIZAÇÃO ENCONTRADA!");
      return latest;
    }

    print("Aplicativo atualizado.");
    return null;
  }
}
