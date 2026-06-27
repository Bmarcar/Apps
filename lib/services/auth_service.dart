import 'package:supabase_flutter/supabase_flutter.dart';

import '../exceptions/app_exception.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get usuarioAtual => _supabase.auth.currentUser;

  bool get estaLogado => usuarioAtual != null;

  Future<AuthResponse> login({
    required String email,
    required String senha,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: senha,
      );
    } on AuthException {
      throw AppException("E-mail ou senha inválidos.");
    } catch (_) {
      throw AppException("Não foi possível realizar o login.");
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<void> recuperarSenha(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}
