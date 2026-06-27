import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../../models/usuario.dart';
import '../../repositories/usuario_repository.dart';
import '../../services/auth_service.dart';
import '../../services/senssion_service.dart';

class LoginController {
  final AuthService _authService = AuthService();
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  Future<void> login({
    required BuildContext context,
    required String email,
    required String senha,
  }) async {
    try {
      final auth = await _authService.login(email: email.trim(), senha: senha);

      debugPrint("================================");
      debugPrint("EMAIL: ${auth.user?.email}");
      debugPrint("UUID: ${auth.user?.id}");
      debugPrint("================================");

      final Usuario? usuario = await _usuarioRepository.buscarPorAuthId(
        auth.user!.id,
      );

      if (usuario == null) {
        throw Exception(
          "Usuário encontrado no Auth, mas não na tabela usuarios.",
        );
      }

      if (usuario.ativo == false) {
        throw Exception("Este usuário está desativado.");
      }

      SessionService.instance.setUsuario(usuario);

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      rethrow;
    }
  }
}
