import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/usuario.dart';

class UsuarioRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Usuario?> buscarPorAuthId(String authUserId) async {
    print("Buscando auth_user_id: $authUserId");

    final response = await _supabase
        .from('usuarios')
        .select('*')
        .eq('auth_user_id', authUserId)
        .maybeSingle();

    print("Resposta:");
    print(response.toString());

    if (response == null) return null;

    return Usuario.fromJson(response);
  }

  Future<Usuario?> buscarPorEmail(String email) async {
    final response = await _supabase
        .from('usuarios')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (response == null) return null;

    return Usuario.fromJson(response);
  }

  Future<Usuario?> buscarUsuarioLogado() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    return buscarPorAuthId(user.id);
  }
}
